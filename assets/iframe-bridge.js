;(function () {
  // default whitelist, always active — extend it via IframeBridge.init() if needed
  const DEFAULT_ALLOWED_PARENT_ORIGINS = [
    'http://localhost:3000',
    'https://yourapp.com',
    // ...інші дозволені домени
  ]

  let allowedParentOrigins = [...DEFAULT_ALLOWED_PARENT_ORIGINS]
  let parentOrigin = null
  let initialized = false

  const parentMessageHandlers = {}

  const queryParams = new URLSearchParams(window.location.search)
  const config = {
    hasAuth: queryParams.get('auth') === 'true',
    locale: queryParams.get('locale') || 'en',
    theme: queryParams.get('theme') || 'light',
  }

  function resolveParentOrigin() {
    // read parentOrigin from the query string, trust it only if it's in the whitelist
    const requestedOrigin = queryParams.get('parentOrigin')
    parentOrigin = allowedParentOrigins.includes(requestedOrigin) ? requestedOrigin : null
  }

  function sendMessage(type, payload) {
    if (!parentOrigin) return
    window.parent.postMessage({ type, payload }, parentOrigin)
  }

  function sendHeight() {
    const height = Math.max(
      document.body.scrollHeight,
      document.documentElement.scrollHeight,
      document.body.offsetHeight,
      document.documentElement.offsetHeight
    )

    // type height
    sendMessage('height', height)
  }

  function initHeightReporting() {
    window.addEventListener('load', () => {
      sendMessage('loaded')
      sendHeight()
    })

    window.addEventListener('resize', sendHeight)

    new ResizeObserver(sendHeight).observe(document.body)
  }

  function handleParentMessage(e) {
    // still validate incoming messages independently — never trust the query param alone
    if (!allowedParentOrigins.includes(e.origin)) return
    // only accept messages sent from the actual parent window
    if (e.source !== window.parent) return

    const { type, payload } = e.data || {}
    const handler = parentMessageHandlers[type]
    if (handler) handler(payload)
  }

  function initParentMessages() {
    window.addEventListener('message', handleParentMessage)
  }

  // options.allowedParentOrigins — extra origins to trust, added on top of the defaults above.
  // Call this once from your app.js, before relying on sendMessage/onParentMessage.
  function init(options) {
    if (initialized) return
    initialized = true

    const extraOrigins = (options && options.allowedParentOrigins) || []
    allowedParentOrigins = [...DEFAULT_ALLOWED_PARENT_ORIGINS, ...extraOrigins]

    resolveParentOrigin()
    initHeightReporting()
    initParentMessages()
  }

  // public API for the custom part below
  window.IframeBridge = {
    init,
    config,
    sendMessage,
    onParentMessage(type, handler) {
      parentMessageHandlers[type] = handler
    },
  }
})()
