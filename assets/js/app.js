import "../css/app.scss"
import "bootstrap"

import "phoenix_html"
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "topbar"
import Hooks from "./_hooks"
import Alpine from "alpinejs"
import "./cookies"

Alpine.start()
window.Alpine = Alpine

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken }, hooks: Hooks, dom: {
    onBeforeElUpdated(from, to) {
      if (from._x_dataStack) { window.Alpine.clone(from, to) }
    }
  }
})

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#E4D8F8" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (info) => topbar.show());
window.addEventListener("phx:page-loading-stop", (info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

