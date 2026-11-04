// Ứng dụng macOS bọc game "Một Ngày Ở MinhLee": một cửa sổ + WebKit có sẵn của hệ điều hành,
// nạp index.html (bản offline) nằm trong Resources của .app. Không mở Safari, không cần mạng.
import Cocoa
import WebKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate, WKNavigationDelegate, NSWindowDelegate {
    var window: NSWindow!
    var web: WKWebView!
    let selfTest = CommandLine.arguments.contains("--selftest")

    func applicationDidFinishLaunching(_ notification: Notification) {
        buildMenu()
        let cfg = WKWebViewConfiguration()
        cfg.mediaTypesRequiringUserActionForPlayback = []          // cho phép phát âm thanh; game tự chỉ bật tiếng sau lần bấm đầu tiên của người chơi
        web = WKWebView(frame: .zero, configuration: cfg)
        web.navigationDelegate = self
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 520, height: 900),
                          styleMask: [.titled, .closable, .miniaturizable, .resizable],
                          backing: .buffered, defer: false)
        window.title = "Một Ngày Ở MinhLee"
        window.contentView = web
        window.minSize = NSSize(width: 360, height: 560)
        window.center()
        window.setFrameAutosaveName("MinhLeeMain")
        window.delegate = self
        window.makeKeyAndOrderFront(nil)
        window.makeFirstResponder(web)
        NSApp.activate(ignoringOtherApps: true)

        guard let url = Bundle.main.url(forResource: "index", withExtension: "html") else {
            debugLog("Không tìm thấy index.html trong Resources")
            showFatal("Không tìm thấy dữ liệu game bên trong ứng dụng. Hãy tải lại ứng dụng.")
            return
        }
        web.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }

    // MARK: - Kiểm tra tải trang
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if selfTest { DispatchQueue.main.asyncAfter(deadline: .now() + 3) { self.runSelfTest() } }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugLog("didFail: \(error)")
        showFatal("Không mở được game. Hãy thử mở lại ứng dụng.")
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugLog("didFailProvisionalNavigation: \(error)")
        showFatal("Không mở được game. Hãy thử mở lại ứng dụng.")
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) { webView.reload() }

    // MARK: - Tự kiểm tra (--selftest): in kết quả ra stdout rồi thoát
    func runSelfTest() {
        let probe = """
        (function(){var ok=false,prev=null;try{prev=localStorage.getItem('__persist');if(prev===null){localStorage.setItem('__persist','yes');}else{localStorage.removeItem('__persist');}localStorage.setItem('__t','1');ok=localStorage.getItem('__t')==='1';localStorage.removeItem('__t');}catch(e){}
        var c=document.createElement('canvas');var gl=c.getContext('webgl2')||c.getContext('webgl');
        return JSON.stringify({ready:window.__gameReady===true,btn:document.querySelector('#btn-start').textContent,
        btnEnabled:!document.querySelector('#btn-start').disabled,storage:ok,persistedFromPreviousLaunch:prev,webgl:!!gl,bootError:!document.getElementById('boot-error').classList.contains('hidden')});})()
        """
        web.evaluateJavaScript(probe) { result, error in
            print("PHASE1", result ?? "nil", error.map { "\($0)" } ?? "")
            self.web.evaluateJavaScript("document.querySelector('#btn-start').click(); 'clicked'") { _, _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    let after = "JSON.stringify({hudVisible:!document.getElementById('hud').classList.contains('hidden'),canvas:document.querySelectorAll('#game canvas').length,clock:document.getElementById('hud-clock').textContent,who:document.getElementById('hud-who').textContent})"
                    self.web.evaluateJavaScript(after) { r2, e2 in
                        print("PHASE2", r2 ?? "nil", e2.map { "\($0)" } ?? "")
                        exit(0)
                    }
                }
            }
        }
    }

    // MARK: - Menu (cần Edit để dán/sao chép trong ô nhập tên)
    func buildMenu() {
        let main = NSMenu()
        let appItem = NSMenuItem(); main.addItem(appItem)
        let appMenu = NSMenu(); appItem.submenu = appMenu
        appMenu.addItem(withTitle: "Ẩn Một Ngày Ở MinhLee", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h")
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(withTitle: "Thoát", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")

        let editItem = NSMenuItem(); main.addItem(editItem)
        let edit = NSMenu(title: "Chỉnh sửa"); editItem.submenu = edit
        edit.addItem(withTitle: "Cắt", action: #selector(NSText.cut(_:)), keyEquivalent: "x")
        edit.addItem(withTitle: "Sao chép", action: #selector(NSText.copy(_:)), keyEquivalent: "c")
        edit.addItem(withTitle: "Dán", action: #selector(NSText.paste(_:)), keyEquivalent: "v")
        edit.addItem(withTitle: "Chọn tất cả", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a")

        let viewItem = NSMenuItem(); main.addItem(viewItem)
        let view = NSMenu(title: "Hiển thị"); viewItem.submenu = view
        let fs = NSMenuItem(title: "Toàn màn hình", action: #selector(NSWindow.toggleFullScreen(_:)), keyEquivalent: "f")
        fs.keyEquivalentModifierMask = [.control, .command]; view.addItem(fs)
        view.addItem(withTitle: "Tải lại game", action: #selector(reloadGame), keyEquivalent: "r")
        NSApp.mainMenu = main
    }
    @objc func reloadGame() { web.reload() }

    // MARK: - Lỗi: ghi log (chỉ khi debug/selftest), hiện thông báo thân thiện cho người dùng
    func debugLog(_ msg: String) {
        #if DEBUG
        NSLog("[MinhLee] %@", msg)
        #endif
        if selfTest { print("LOG", msg) }
    }
    func showFatal(_ text: String) {
        let a = NSAlert(); a.messageText = "Có chút trục trặc"; a.informativeText = text; a.addButton(withTitle: "Đóng"); a.runModal()
        NSApp.terminate(nil)
    }
}

MainActor.assumeIsolated {
    let app = NSApplication.shared
    let delegate = AppDelegate()
    app.delegate = delegate
    app.setActivationPolicy(.regular)
    app.run()
}
