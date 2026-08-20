#!/usr/bin/env node

import fs from 'node:fs'
import path from 'node:path'

const args = process.argv.slice(2)
const requireDist = args.includes('--require-dist')
const positional = args.filter((arg) => !arg.startsWith('--'))

if (positional.length !== 1 || args.some((arg) => arg.startsWith('--') && arg !== '--require-dist')) {
  console.error('Usage: validate-landings-config.mjs <repository-root> [--require-dist]')
  process.exit(64)
}

const root = path.resolve(positional[0])
const configPath = path.join(root, 'landings.json')
const errors = []

function fail(message) {
  errors.push(message)
}

function isSafeRelative(value) {
  return !path.isAbsolute(value) && value !== '' && !value.split(/[\\/]+/).includes('..')
}

if (!fs.existsSync(configPath)) {
  console.error(`ERROR missing ${configPath}`)
  process.exit(1)
}

let config
try {
  config = JSON.parse(fs.readFileSync(configPath, 'utf8'))
} catch (error) {
  console.error(`ERROR invalid JSON in ${configPath}: ${error.message}`)
  process.exit(1)
}

if (!config || Array.isArray(config) || typeof config !== 'object') {
  console.error('ERROR landings.json root must be an object')
  process.exit(1)
}

const usedPaths = new Map()

for (const [landingId, entry] of Object.entries(config)) {
  const label = `landing ${JSON.stringify(landingId)}`
  if (!landingId || landingId === '.' || landingId === '..' || landingId.includes('/') || landingId.includes('\\')) {
    fail(`${label}: key must be a non-empty directory name`)
  }
  if (!entry || Array.isArray(entry) || typeof entry !== 'object') {
    fail(`${label}: configuration must be an object`)
    continue
  }

  const allowedFields = new Set(['enabled', 'path', 'dist', 'build'])
  for (const field of Object.keys(entry)) {
    if (!allowedFields.has(field)) fail(`${label}: unknown field ${JSON.stringify(field)}`)
  }

  if (typeof entry.enabled !== 'boolean') fail(`${label}: enabled must be boolean`)
  if (typeof entry.path !== 'string' || !entry.path.startsWith('/') || entry.path === '/' || entry.path.endsWith('/')) {
    fail(`${label}: path must start with /, must not be /, and must not end with /`)
  } else if (usedPaths.has(entry.path)) {
    fail(`${label}: path ${JSON.stringify(entry.path)} duplicates ${JSON.stringify(usedPaths.get(entry.path))}`)
  } else {
    usedPaths.set(entry.path, landingId)
  }

  if (typeof entry.dist !== 'string' || !isSafeRelative(entry.dist)) {
    fail(`${label}: dist must be a safe repository-relative path`)
  }
  if (typeof entry.build !== 'string' || entry.build.trim() === '') {
    fail(`${label}: build must be a command or exact value "static"`)
  }

  const landingDir = path.join(root, landingId)
  if (!fs.existsSync(landingDir) || !fs.statSync(landingDir).isDirectory()) {
    fail(`${label}: directory ${landingDir} does not exist`)
  }

  if (entry.build !== 'static' && fs.existsSync(landingDir)) {
    if (!fs.existsSync(path.join(landingDir, 'package.json'))) fail(`${label}: built landing is missing package.json`)
    if (entry.build.includes('npm ci') && !fs.existsSync(path.join(landingDir, 'package-lock.json'))) {
      fail(`${label}: npm ci build is missing package-lock.json`)
    }
  }

  if (entry.build === 'static' && typeof entry.dist === 'string' && isSafeRelative(entry.dist)) {
    const staticIndex = path.join(root, entry.dist, 'index.html')
    if (!fs.existsSync(staticIndex)) fail(`${label}: static dist is missing index.html at ${staticIndex}`)
  }

  if (requireDist && typeof entry.dist === 'string' && isSafeRelative(entry.dist)) {
    const distDir = path.join(root, entry.dist)
    if (!fs.existsSync(distDir) || !fs.statSync(distDir).isDirectory()) {
      fail(`${label}: built dist directory does not exist at ${distDir}`)
    } else if (!fs.existsSync(path.join(distDir, 'index.html'))) {
      fail(`${label}: dist is missing index.html at ${path.join(distDir, 'index.html')}`)
    }
  }
}

if (errors.length) {
  for (const error of errors) console.error(`ERROR ${error}`)
  console.error(`landings.json validation failed with ${errors.length} error(s).`)
  process.exit(1)
}

console.log(`OK ${Object.keys(config).length} landing(s); paths are unique and configuration is structurally valid.`)
if (!requireDist) console.log('NOTE run again with --require-dist after executing configured builds.')
