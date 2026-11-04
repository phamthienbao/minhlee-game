# Player Guide: Một Ngày Ở MinhLee

*One Day at MinhLee* is a calm, one-person game. You play a new employee at MinhLee, a small company that builds mobile apps and games. Its best-known product is the dating app, **App Dating**. Each day is one ordinary workday in the office with 14 coworkers. The days follow on from each other, Monday to Friday, week after week, and the game has no end. (MinhLee, App Dating, and everyone in the game are fictional.) Nothing is timed against you, there is no way to lose, and there is no score. You decide how to spend each day: finish a task, have a chat, join the meeting, take a break, or just walk around.

The game is in Vietnamese and runs in your web browser. You can play it as a **guest** on your own device, or sign in with a company email to play as one of the coworkers and keep your progress on the server (see **Signing in** below). A guest game works offline after it has loaded once. Signing in needs an internet connection.

## Getting started

1. Open `index.html` in a recent web browser: Chrome 89 or newer, Edge 89 or newer, Firefox 108 or newer, or Safari 16.4 or newer. If you were given a file called `index-offline.html` instead, open that one. It works with no internet connection at all. Do not open the link inside a chat app such as Zalo or Messenger. Choose "Mở bằng trình duyệt" (open in browser) first.
2. With `index.html`, you need an internet connection the first time so the 3D library can download. After that you can play offline.
3. On the title screen, type your name if you like (optional, up to 16 characters). Then choose how you want coworkers to address you: **Nam**, **Nữ**, or **Không nêu** (no preference). You can also pick one of the 4 looks.
4. Press **"Bắt đầu ngày mới"** (Start a new day). A short tutorial appears at the bottom of the screen.
5. Your day begins at **08:30**.

**On a Mac (app):** if you were sent `MinhLee-mac.zip`, unzip it and open **MinhLee.app**. The game opens in its own window and needs no internet connection. The first time, macOS may warn that it cannot check the app. See the FAQ below.

If you leave the name empty, coworkers simply call you "bạn" (you).

After your first day, the title screen button reads **"▶ Tiếp tục"** (Continue). It shows the weekday and week of the next day, for example "Thứ Ba, tuần 1".

If you play as a guest, your progress is saved only on this device, and no account is needed. The Mac app keeps its own save, separate from your web browser. Your day in progress is saved too, so you can carry on after closing the game (see **Saving your day** below). If you sign in with a company email, your progress is saved on the server instead (see **Signing in**).

## Signing in

Company members can sign in with their company email and a password. Your administrator creates your account and gives you your password in person. There is no sign-in email. This is a preview (alpha). Sign-in and saving on the server were tested by the project owner in November 2026, but the game is still in preview. The sign-in button is not shown in the normal game. See the note for administrators and testers at the end of this section.

**To sign in:**

1. On the title screen, press **🔑 Đăng nhập công ty** (Company sign-in).
2. Type your company email and your password, then press **Đăng nhập** (Sign in). You can also press Enter in the password box.
3. The game opens with your coworker's character. A welcome window says **"Chào <tên>!"** (Hello, <name>!). Press **▶ Tiếp tục** (Continue).

What changes when you are signed in:

- **You are one of the coworkers.** Your name, gender, and look come from that coworker. That coworker is not in the office in your game, because you take their place. Your character never gives you a job, and does not ask you about the missing document.
- **Your progress is kept on the server.** Your days, finished jobs, unlocked desk items, how close you are with each coworker, your diary, and the day in progress are saved there. Changes are sent about 2 seconds after you make them, and also when you switch to another tab or close the window. If the connection drops, the game tries again. A short message appears if the save is delayed.
- **You sit at your own character's desk** in the office, and the items you unlock appear on that desk. After you log out, your guest desk at the bottom left of the office is shown again.
- **Coworkers call you by your character's name.** For example, Anh Bảo is "anh Bảo", Chị Ba is "chị Ba", Chú 7 is "chú 7", and Chủ tịt is "Chủ tịt". Everyone else uses the character's name. Your own name on the screen stays the real name.
- **Your guest save on this device is not changed** by the days you play while signed in.
- The title screen's name and gender form is not shown. The welcome window replaces it.

**One window at a time.** Open the game in only one browser tab or on one device for each company account. If you sign in to the same account in a second tab or on a second device, that newer window keeps your progress. The older window then shows **"⚠ Tài khoản đang được mở ở nơi khác"** (This account is open somewhere else) the next time it tries to save, usually within a few seconds of your next move. From that moment it stops saving, so it cannot overwrite the newer progress. Changes you make in that window are not saved. Close it, or press **🔄 Tải lại trang** (Reload the page) to load the latest progress from the server. Guest play in another tab does not affect your account.

**Log out:** in the welcome window, press **🚪 Đăng xuất** (Log out). The game saves your last changes first. Then it goes back to the sign-in screen, and your guest save on this device is shown again, exactly as you left it.

**Playing as a guest:** on the sign-in screen, press **🎮 Chơi Guest (nhân viên mới)** (Play as a guest, new employee). The game then keeps you as a guest. The next time you open the game, it opens your guest save directly. To sign in later, press **🔑 Đăng nhập công ty** on the title screen (shown only when the sign-in button is turned on, see the note below).

**Reset for signed-in players:** please do not use **🗑 Xóa dữ liệu** (Delete data) while signed in. What it does to your saved progress on the server is still being checked. See the FAQ.

**Note for administrators and testers (not for players):** the sign-in button is hidden in every browser until it is turned on there.

- To show the button in your browser, open the game with `?login` added to its web address, for example `index.html?login`. The button stays on in that browser for later visits.
- To hide it again, open the game with `?login=off` added to the address.
- The setting is kept per browser, so it does not change the game for anyone else.
- Sign-in works only when the game is opened from its web address, not from the file on your computer.
- Hiding the button is not a security measure. Access to company data is protected by the server, not by the hidden button.

## Controls

| Action | Computer | Phone or tablet |
|---|---|---|
| Walk | **W A S D** or **arrow keys** | Drag the joystick at the bottom left |
| Turn the camera | Drag the mouse on the screen | Drag a finger on the screen (not on a button) |
| Zoom the camera | Mouse wheel | — |
| Change the camera view | **🎥** button at the top right (cycles three views: close, medium, far) | **🎥** button at the top right |
| Interact | **E**, **Space**, or **Enter** (or click the big button) | Tap the big button that appears on the right |
| Pause | **P** or **Esc** (or the ⏸ button, or tap the goal box at the top) | ⏸ button at the top right (or tap the goal box) |
| Mute or unmute sound | **M** (or the 🔊 button) | 🔊 button at the top right |
| Fast-forward time | — | ⏩ button at the top right (press again to return to normal speed) |

The three camera views are **Gần** (close), **Vừa** (medium, the default), and **Xa** (far, looking down from above). Your choice is remembered on this device.

When you get near something you can use, the big button shows what it does. Some things can be used from the list-style menu instead, if your browser cannot show 3D graphics.

## Your day

Time runs from **08:30** to **18:00**. One full day takes about 7 and a half minutes at normal speed. The clock is shown at the top of the screen, and the box below it shows your current goal. Tap that box to pause and see the full list for the day (see "The mission board" below).

| Time | Milestone | What to do |
|---|---|---|
| 08:30 | **Đến công ty** (Arrive) | Greet at least 2 coworkers. Walk up to someone and press the action button. |
| 09:00 | **Buổi sáng** (Morning) | Go to your desk (the yellow spot at the bottom left, next to Thông's desk). A label "💻 Bàn của bạn" (My desk) floats above it. If the desk is off-screen to one side, the label sticks to that edge of the screen to show the way. A coworker asks you for a small job, which takes about 30–60 seconds. There is no score. If you finish fewer than 2 jobs by the end of the day, the coworker who asked you comes by to remind you (see "Ending the day"). You can also choose **🪑 Ngồi làm việc (thời gian trôi qua)** (Sit and work, time passes) to sit at your desk while the clock runs fast; see "Sit and let time pass" below. There are two kinds of job: sort notes into projects (for example App Dating, Game mới, or App tiện ích), or put work items in deadline order. Up to 3 jobs a day. Each finished job also counts toward new items for your desk (see "Your desk and its items" below). Press "▶ Bắt đầu làm" (Start) to begin. |
| 10:00 | **Họp ngắn** (Short meeting) | Go to the meeting room (top middle, between the two long tables) and sit at the meeting table to join in. The meeting runs until 10:55. Chủ tịt (Thạnh) hosts it. The topic changes from day to day. On Mondays it is about the next App Dating version. One possible topic is a partner asking to push back the App Dating feature deadline by 2 days. If you miss it, Chủ tịt sends you a short summary. |
| 11:00 | **Giải lao** (Break) | Visit the pantry (top left). Pick a drink and chat with someone. You can invite a coworker to join you. Around 11:05, Chủ tịt buys drinks for everyone, which gives you a little energy and mood. The drink is chosen at random: milk tea, rau má (a green herbal drink), or sugarcane juice. Chủ tịt asks people to come to the pantry. Up to eight coworkers gather there with him, and everyone else finds a takeaway cup on their desk. Around 14:10 he buys snacks instead. On milk-tea days he also treats the team around 09:55 and 16:00. |
| 12:00 | **Ăn trưa** (Lunch) | Eat at the pantry. Lunch is available until about 13:40. |
| 13:30 | **Buổi chiều** (Afternoon) | Help out. A coworker may ask you to fetch a document from the filing cabinet (bottom right). Listen to what they ask for, because the game will not remind you of the name later (see "The document request" below). Other events can happen: a printer jam, or a small birthday cake party in the pantry. Around 14:10, Chủ tịt brings snacks for everyone. |
| 17:30 | **Kết thúc ngày** (Wrap-up) | Time to wrap up. You can leave a sticky note for a coworker, then leave through the front door (on the right-hand wall, in the middle). |
| 18:00 | **Tan ca** (End of the workday) | The farewell scene starts. See "The farewell scene at 6 pm" below. |

You can also leave early from the front door after 16:00. If you leave before 17:40, the game asks you to confirm.

### Who can ask you for a job

Every coworker who is in the office that day can ask you for a small job. That includes Anh Bảo, Chị Ba, Yến, Thảo, Chủ tịt, Nam, Phú, Trung, Toàn, Hiện, Tùng, Chú 7, Thông, and Nguyên. Each one has their own way of asking. Some jobs sort notes into projects, and some put tasks in deadline order. Nguyên works from home on some days, so he does not ask on those days. Each coworker asks for a different kind of work, so the job you get depends on who is in the office and on chance.

### Other places in the office

- **Pantry** (top left corner): the drinks and lunch corner. A round table stands in the middle, with room for up to eight people around it. When Chủ tịt treats the team, the table fills up: takeaway cups for a drink, or one dish (pizza, roast duck, takoyaki, or fried fish balls) for the afternoon snack. It is cleared once the treat is over.
- **Sofa** (top right corner): rest to restore energy. Available while your energy is not nearly full.
- **Notice board** (right-hand wall, next to the front door): read the notes posted there. They may be office gossip, or news about App Dating.
- **Filing cabinet** (bottom right): where the document favor is fetched.
- **Printer** (left wall): may jam during the afternoon event. On those days, Nam is the one standing at it.
- **Daybed** (back wall, next to the pantry): Nguyên takes one short nap here after lunch, on the days he comes into the office. The rest of the day he works at his desk on the right-hand table. You can walk around it.
- **Desks**: your desk is the yellow one at the bottom left. Nine coworkers share two long tables, one on the left and one on the right, and sit facing each other across them. Five more coworkers have single desks in the bottom row, to the right of your desk. Nguyên works remotely. When he is in, he sits on the right-hand table, next to Chú 7. Some coworkers wander over to chat at a colleague's desk during the day. Trung sometimes stops by Nguyên's desk to talk about his designs.

### Your desk and its items

Your desk fills up over time. Every job you finish counts toward a total that keeps growing from day to day. When the total reaches a set number, a new item appears on your desk.

| Jobs finished (total) | Item | What it is |
|---|---|---|
| 1 | ☕ Cốc cà phê MinhLee | Your first mug as a full-time employee |
| 2 | 🌵 Chậu xương rồng mini | A small cactus. Easy to look after, like you in your new job |
| 4 | 🦆 Vịt cao su “Debug” | A rubber duck. Explain the bug to the duck and it is solved (usually) |
| 6 | 🐱 Mèo may mắn | A lucky cat, a gift from Chủ tịt, of course |
| 9 | 💡 Đèn bàn ấm áp | A desk lamp for late afternoons |
| 13 | 🖼 Khung ảnh cả team | A team photo. Everyone closes their eyes except Thảo |
| 18 | 🎧 Tai nghe chống ồn | For when Nam's typing gets too loud |
| 25 | 🏆 Cúp “Người đồng hành” | The whole office chipped in. Chủ tịt paid the rest |

- When you unlock an item, a reward card appears after the coworker's reply.
- The work card for a new job shows the next item and how many jobs are left until it.
- To see your progress, pause the game and press **🎁 Đồ trên bàn làm việc** (Items on the desk). Locked items show their name and how many jobs are left. Unlocked items show a short description.
- The items appear on your desk in the 3D office. In the simple list mode they are not drawn, but your progress still counts.
- The count does not reset from one day to the next. Three jobs a day is the most you can finish, so the last item takes at least 9 working days.

### Your stats

- **Energy (⚡)**: drops slowly over the day. Tasks and events use some energy. Pantry food, rest, Chủ tịt's treats, and some conversations restore it.
- **Mood (🙂)**: changes with what you do and how coworkers react. Shown as a label, from "Cần nghỉ" (need rest) to "Rất vui" (very happy).
- **Tasks (✅)**: number of small tasks finished today.
- **Affinity (💛)**: how close you are with each coworker. Shown as hearts in the diary. Chatting, helping, kind notes, and Chủ tịt's treats raise it.

### The mission board

Tap the goal box at the top of the screen, or press **P** or **Esc**, to pause. The pause menu shows the mission board under the **▶ Tiếp tục** (Continue) button. It has three parts:

- **Việc cần làm bây giờ** (What to do now): the goal for the current time, in a highlighted box at the top.
- **Các mốc trong ngày** (The day's milestones): every milestone with its time and a symbol.
  - ✅ done
  - ▶️ the current milestone, with its tip shown underneath
  - ⏳ still to come
  - ⏭ the time has passed without finishing it. The game says: "Đã qua, không sao cả, ngày vẫn tiếp tục" (It has passed, that's fine, the day goes on).
- **Việc nhỏ hôm nay** (Small things today): desk work (up to 3), the afternoon file request, a printer jam, a birthday party in the pantry, and leaving a note for a coworker after 16:00. Each item shows ✅ when it is done, or 🔹 when it is not.

Missing a milestone does not end the game or count against you. Close the menu with **▶ Tiếp tục** to go back to the day.

### Sit and let time pass

When you sit down at your desk, the first choice is **🪑 Ngồi làm việc (thời gian trôi qua)** (Sit and work, time passes).

- The clock runs fast, about five game minutes every real second. A full workday takes about 2 minutes.
- The camera slowly turns around the office. A small clock and the words "Đang ngồi làm việc…" (Sitting and working…) show at the top of the screen.
- Coworkers keep going about their day while you sit.
- Tap or click anywhere, or press Space, Enter, or Esc, to stop. You return to the job menu.
- The clock also stops by itself when the next milestone starts. A notice shows the time and the milestone, and the job menu opens again.
- Time-lapse does not count as a finished job. If you want the job to count, choose **▶ Bắt đầu làm** (Start) instead.
- At 18:00 the farewell scene starts, as usual (see "The farewell scene at 6 pm").

### The document request

In the afternoon, a coworker may ask you for a favour: fetch a document from the filing cabinet.

1. Go to the coworker and choose **📎 Hỏi xem họ cần gì** (Ask what they need). They tell you which document they want. Remember it.
2. Choose **Được ạ, để mình đi tìm** (Sure, I'll go and look). If you are busy, choose the other option. The request stays open, and you can ask again later.
3. Go to the filing cabinet (bottom right, near the door) and tap **Tìm hồ sơ** (Find document). The drawer shows several documents. Pick the one they asked for.

The hints do not name the document. If you forget, go back to the coworker and choose **🔁 Hỏi lại: cần lấy gì nhỉ?** (Ask again: what was it I needed?). Asking again costs nothing.

If you pick the wrong document, the coworker says so in their own way and tells you again what they need. You can go back to the drawer, or leave it for later. There is no penalty. Bringing the right document earns the coworker's thanks and a bit more closeness with them, and the badge **🗄 Thám tử hồ sơ** (Document detective) at the end of the day.

## Surprises, day types, and weekends

### Surprises

- Each day, **3 surprises** are planned for random times. On busy days there are 4. A card pops up with **3 choices**. Each choice has its own result, and changes your mood, your energy, or how close you are with someone.
- A surprise does not pop up from wherever you are. Once its time comes, it waits until you **walk up close to the coworker involved**, within a few steps of them. Then the card appears. If the surprise has no particular coworker, walk near any coworker who is in the office.
- If you do not get close to the right person in time, the surprise is skipped for that day. It waits up to 2½ hours on the clock, and never past 5:10 pm. Nothing is shown when a surprise is skipped.
- Some surprises involve one particular coworker. If that person is out of the office, that surprise will not come up.
- Some day types (see "Day types" below) open with a **short story** at about 8:50 in the morning. The story comes up when a coworker is nearby, like a surprise. It has three choices too. Story days can have one more surprise than usual.
- Sometimes a **mystery gift box** turns up. Pick one of the three boxes to see what is inside.
- The same surprise does not come back on the next day.

### Day types

Each day has a type. It shows as an emoji next to the clock, and the message at the start of the day names it.

| Emoji | Day type | What it feels like |
|---|---|---|
| 🌤 | Normal day (Ngày bình thường) | A quiet, ordinary day |
| 🌧 | Rainy day (Ngày mưa) | Grey light outside and the sound of rain. Everyone wants hot coffee |
| 🔥 | Busy day (Ngày chạy nước rút) | Everyone is busy. Energy runs down faster, and there are more surprises |
| 🌿 | Relaxed day (Ngày thư thả) | No rush. Coworkers chat more often |
| 🧋 | Milk-tea day (Ngày trà sữa) | Chủ tịt brings milk tea several times |
| 🤝 | Demo day (Ngày khách tới xem demo) | A partner visits to see the App Dating demo. Everyone tidies up |
| 🔌 | Wifi day (Ngày wifi chập chờn) | The wifi keeps dropping. Someone always has a backup plan |
| 🐈 | Cat day (Ngày mèo ghé thăm) | A stray cat walks into the office. Chủ tịt is delighted |
| 🏁 | Hackathon day (Ngày hackathon mini) | Teams are formed for a small one-day project. Busy and fun |
| 🤧 | Sneezing day (Ngày giao mùa) | The weather changes and everyone sneezes. Ginger tea is popular |
| 🏆 | Award day (Ngày bình chọn tháng) | The office votes for "Coworker of the month", and nobody admits to caring |

The day type is picked at random and usually does not repeat from one day to the next.

### Weekends

- After Friday's summary, a short **weekend** note appears. Monday starts with a little more mood and energy.

### App Dating: users and version

- The App Dating app has a **user count** (in thousands) that grows a little each day. You can see it in the end-of-day summary and on the notice board.
- Its **version** goes up each week (v1.0, v1.1, and so on). The Monday meeting is about the upcoming version.

## Ending the day

### The farewell scene at 6 pm

At 18:00 the office starts to go home. The camera turns slowly around the room, and the clock keeps running for a little while.

- Your coworkers say goodbye and leave one by one. Chủ tịt (Thạnh) is the last to go, apart from Toàn.
- Toàn stays behind to keep working until 7 pm.
- Once everyone except Toàn has gone, or after about 40 game minutes, the scene ends.
- You are then told who is still in the office. Choose **"🏠 Về thôi"** (Let's go home) to finish the day and go on to the steps below.
- If you leave through the front door before 6 pm, the scene is skipped.

If you finished fewer than 2 jobs today, the coworker who gave you a job comes to your desk before you leave. Each coworker reacts in their own way. Chị Ba scolds you and gives you a light punch, Yến asks what happened, Thảo says it is fine and promises a treat, and Anh Bảo asks why. Every other coworker who can ask you for a job has a reaction of their own too. If the coworker who gave you the job has already left the office, they send you a message instead of coming by. You lose a little of their friendliness and a little mood. If you say sorry, they forgive you and your friendliness goes up a little. The same reminder comes if you leave early.

At the end of the day you can:

1. **Write a sticky note** for one of the coworkers you talked with (or anyone else). Pick a preset message or type your own (up to 50 characters). This is optional.
2. **Read the summary.** It shows your tasks, energy, who you talked to, memorable moments, notes from coworkers, a closing comment, the day's badges, and the App Dating user count and version.
3. Choose **"☀ Sang ngày tiếp theo"** (Go to the next day) to keep going. On Friday the button reads **"🌙 Qua cuối tuần"** (Go through the weekend), and a short weekend note comes first. You can also open **"📖 Nhật ký"** (Diary) or go to **"🏠 Màn hình chính"** (Title screen).

Each day is saved to your diary when it ends. The diary keeps the most recent 150 days. If you leave in the middle of a day, that day is not written to the diary yet, but it is kept and you can continue it (see **Saving your day**).

## Diary and data

- **Diary** (📖 *Nhật ký ngày làm*): available from the title screen, the pause menu, and the end-of-day summary. It lists each day, and at the bottom shows how close you are with each coworker.
- **What the diary says at the top**: during a workday, it tells you which day you are on and that today is written in the diary at the end of the day. Outside a workday (on the title screen or after the summary), it tells you how many days you have worked, or that no day has been recorded yet.
- **Reset** (🗑 *Xóa dữ liệu*): on the title screen or at the bottom of the diary. This deletes your name, gender choice, avatar, diary, camera view, coworker closeness, and the App Dating user count and version on this device. It cannot be undone. Signed-in players: see **Reset for signed-in players** under **Signing in**.
- **Replay the tutorial**: from the pause menu, choose "Xem lại hướng dẫn".

### Saving your day

- Your day is saved about every 5 seconds while you play. It is also saved when you switch to another tab or close the window. The last few seconds of play may be lost.
- Kept: the time, your tasks, energy and mood, your position and direction, how close you are with each coworker, surprises that already happened, your desk job progress, the day's type, and the cake party or printer jam of that day.
- Not kept: open cards and windows, speech bubbles, and exactly where each coworker was. Coworkers go back to their usual plan for that time.
- When you come back, the title screen shows **▶ Tiếp tục ngày đang dở** (Continue the day in progress) with the time it stopped.
- **Welcome back:** when you open the game and you have played before, a window says **"Chào mừng … quay lại!"** (Welcome back). It tells you if a day is still in progress and at what time.
  - **▶ Tiếp tục ngày đang dở** (Continue the day in progress) picks up where you stopped. If no day is in progress, the button reads **▶ Tiếp tục chơi** (Keep playing) and starts your next day.
  - While the welcome window is open, the name and gender form is hidden, so the choices above are the only thing you see.
  - **🆕 Chơi mới** (New game) asks you to confirm first. **🗑 Xóa hết và chơi mới** (Delete everything and start over) erases your name, diary, closeness with coworkers, and unlocked items on this device, and then shows the name form again. **Thôi, quay lại** (Never mind) goes back to the welcome window, with the name form still hidden.
  - The first time you play, there is no welcome window. You go straight to typing your name.
- Each guest save belongs to one device and one browser. A copy of the game opened from a file, from a web address, or in the Mac app keeps its own save. There is no way to move a guest save to another device yet.
- A signed-in save is kept on the server. It follows your company account, so it can be opened on another device after you sign in there. Your guest save on each device stays separate.

## The coworkers

| Name | Nickname | Team | Personality |
|---|---|---|---|
| Chủ tịt (Thạnh) | | Leadership (hosts the meeting) | Kind, polite, and often ready to help. He calls himself "em" and most people "anh" or "chị", even in group talk. Often runs a little late, but often brings drinks or snacks for the team. Talks about karma (nhân quả), meditation, and spiritual practice. Around 13:20 he closes his eyes to meditate for a few minutes. He loves cats, and his cat is called Nhân Quả. Around lunchtime he looks at photos of her on his phone, and a small stuffed cat sits on his desk |
| Phú | Siêu nhân may mắn | Backend developer | Has a lot of bad luck, loves investing (and losing), and is a big fan of massages |
| Trung | | Backend developer | Loves explaining things and often starts with "Em nói thiệt" ("honestly"). A playful, slippery type, into side businesses and investing, but very focused at work |
| Toàn | | Backend developer | Quiet and calm. Says little, listens a lot |
| Hiện | | Mobile developer | Loves jokes and games |
| Tùng | | Mobile developer | Friendly and sociable. Often invites people out for a light drink after work (nhậu), and loves dares and challenge games. Try saying "MinhLee" ten times in a row |
| Nam | | Mobile developer | Cheerful, with a habit of saying "khìn khìn". Talks to you as a peer, and is the same age as Chủ tịt. Before Chủ tịt arrives in the morning, he sometimes says he misses him, and jokes that the boss is late. He teases Chủ tịt with the playful nickname "bé Hạnh", but calls him "Thạnh" when they talk about work. Around 9:42 he reminds Thạnh that the 10:00 meeting is coming up |
| Thảo | Bella | HR (brings the birthday cake) | Caring, and the office foodie. Knows many restaurants, drink shops, and good dishes, and most chats are about food. Often brings cakes and treats. Around lunchtime suggests where to eat |
| Yến | Én Pink | QC | A little grumpy in a playful way. Loves teasing and asks "Là sao?" a lot |
| Chú 7 (An) | | QC | Young and cheerful. Loves tea (ô long or lotus tea, and has opinions about both). Often teases Chị Ba, who answers with a playful shoulder punch. Chị Ba's teasing nickname for him is "bánh tét" |
| Chị Ba (An) | | Business Support (helps with product research: runs user surveys, writes reports, and checks the numbers) | Strict in a fun way, and careful with numbers. Asks you for help with survey results and reports. Playfully gives colleagues a light shoulder punch (it is a joke). When she gets up from her desk, she sometimes grumbles that the "bánh tét" guy is nowhere to be found, and Chú 7 may answer from behind his cup of tea. This happens more often on busy days. She has a golden cat named Nghệ, and she and Chủ tịt tease each other about whose cat is better, all in fun |
| Anh Bảo | | Product | The oldest in the office. Asks "vì sao" (why) a lot. Likes connecting people. Currently weighing a Dating-app matching suggestion feature against fixing a login bug |
| Thông | Bamboo | R&D | Cheerful and enthusiastic about new ideas. Talks about real estate, land, and investing, and always wants a backup plan |
| Nguyên | | Designer (works remotely) | Relaxed. Often works from home, and comes into the office on about half of the days. When he is in, he works at his desk on the right-hand table and takes a short nap on the daybed after lunch |

Most coworkers call each other by their first names. A few are called by a title: Anh Bảo, Chủ tịt, and Chị Ba.

When you talk to a coworker, the card shows their name, their real name (if it is different from the name above), their nickname, their job title, and how close you are (hearts). It also shows a short line about what they are doing right now, and their own words. Everyone here is fictional. Each coworker has a different personality. Some like jokes, some like a warm tone, and some prefer serious talk. You may notice this when you chat with them.

Speech bubbles float above the head of the coworker who is speaking. If that coworker is out of view, or their head is hidden under the top bar, the bubble is hidden too. What a coworker says usually fits what they are doing: at the pantry they talk about the pantry, in a meeting they say they are busy, and some remarks depend on the time of day.

Some coworkers are close, and they have their own short chats when they visit each other's desks. Coworkers who like you a lot greet you like a close friend.

## Frequently asked questions

**Can I just sit at my desk and let the day pass?**
Yes. Sit at your desk and choose **🪑 Ngồi làm việc (thời gian trôi qua)**. Time runs fast and the camera turns slowly around the office. Tap the screen to stop. Sitting this way does not count as a finished job.

**A coworker came to my desk at the end of the day because I did not finish their job. Why?**
You finished fewer than 2 jobs that day. The coworker who gave you a job reminds you. Say sorry to get some friendliness back. The day still ends as usual, and you can still write a sticky note and read the summary.

**Who can ask me for a job?**
Any coworker who is in the office that day, from Anh Bảo to Nguyên. Nguyên works from home on some days, so he does not ask then. See "Who can ask you for a job" under "Your day".

**How do I unlock the items on my desk?**
Finish desk jobs. Each finished job counts toward the next item. Open **🎁 Đồ trên bàn làm việc** from the pause menu to see what is left.

**I finished jobs but I do not see new items on my desk.**
Items appear in the 3D office. In the simple list mode, they are not drawn. Your progress still counts, so the items will show up if you switch back to 3D.


**I forgot what the coworker asked me to bring. What do I do?**
Go back to that coworker and choose **🔁 Hỏi lại: cần lấy gì nhỉ?** (Ask again). They repeat the request. Asking again has no cost.

**Can I lose or fail?**
No. There is no failure state and no score. The goal is to have a pleasant day.

**Do I need an internet connection?**
If you open `index.html`, you need one the first time, so the 3D library can download. After that, the guest game works offline. If you open `index-offline.html`, you never need one for the guest game. Signing in always needs an internet connection. If the sign-in part cannot load, you can still play as a guest.

**Is MinhLee a real company? What is App Dating?**
No. MinhLee, its coworkers, and App Dating exist only inside the game. The office, the sign, and the coworkers are all made up.

**macOS says it cannot open MinhLee because the developer is unidentified. What do I do?**
This is normal for this app. It is not signed by an Apple developer account and not checked by Apple. Right-click (or Control-click) **MinhLee.app**, choose **Open**, then click **Open** again. You only need to do this once.

**macOS says MinhLee is damaged and cannot be opened. What do I do?**
Ask the person who sent it to send the file again. If you trust the file, open the Terminal app, type `xattr -dr com.apple.quarantine ` (with a space at the end), drag **MinhLee.app** into the Terminal window, and press Return. Then open the app again.

**Is there a Windows version?**
Not as an app. On Windows, open `index-offline.html` in a web browser, as described above.

**Is my data sent anywhere?**
Guest play: no. Your progress is saved only in your browser on this device, and nothing is uploaded. Signed-in play: your progress is saved on the game's server, linked to your company account. See **Signing in**.

**Do I get an email to sign in?**
No. Your administrator creates your account and gives you your password in person. The game does not send any sign-in emails.

**I forgot my password. What do I do?**
Ask the person who runs the game (the administrator). They set a new password and tell you privately. The game has no reset link.

**The game says the email or password is not right.**
Check both, including capital letters. If you are not sure of your password, ask the administrator. The game also says this if your account does not have a password yet.

**The game says my account is not yet activated.**
Ask the administrator to check your account.

**Can I change my password inside the game?**
Not yet. Ask the administrator to set a new one.

**I do not see the "🔑 Đăng nhập công ty" button on the title screen.**
The button is hidden for players who are not testing sign-in. If you are a company member, ask the administrator to turn it on in your browser (see the note in **Signing in**).

**I signed in, but the game says my account is not linked to a character.**
The company email is not yet linked to a coworker. Ask the person who runs the game to check it. You are signed out, and the sign-in screen shows the message again.

**I see "Chưa lưu được lên máy chủ" (Could not save to the server yet).**
The game keeps your changes and tries again every 15 seconds. You can keep playing. If the message stays for a long time, check your internet connection.

**I see "⚠ Máy chủ chưa cấp quyền lưu tiến độ" (The server is not yet allowed to save progress).**
The game server is not set up to save player progress yet. This is a setup problem, not something you did. Tell the person who runs the game, and ask them to check the server permissions. The game keeps trying every 15 seconds, and the message appears at most once a minute. Keep the game open until the save works. Changes made while the save is failing can be lost if you close the page first. Once the server is set up, the message stops and your progress is saved as usual.

**I see "⚠ Tài khoản đang được mở ở nơi khác" (This account is open somewhere else).**
Your account was opened in another tab or on another device, and that one saved newer progress. This window has stopped saving so the two do not overwrite each other. Close the other windows of the same account, then press **🔄 Tải lại trang** (Reload the page) in the window you keep. Keep playing in only one window at a time.

**My welcome window says 0 days, but I had a day in progress.**
A day is counted only when it ends, and a finished job is counted only when it is done. So during your first day, 0 days is correct. The day in progress is saved too. Look for **▶ Tiếp tục ngày đang dở** (Continue the day in progress) on the welcome window. If it is missing and the game starts a fresh morning, another window of the same account probably saved after you. Close the other windows, then reload the game page in the one you keep.

**The welcome window has a line starting with "☁ Đã tải từ máy chủ" and a note in brackets ("chẩn đoán").**
This is a temporary note for the people checking the server saves. It shows what the server sent: days, finished jobs, unlocked items, and the day in progress. You can ignore it. If something looks wrong, tell the person who runs the game. The note will be removed later.

**I see "⚠ Không khôi phục được ngày đang dở nên đã bắt đầu một ngày mới" (Could not restore the day in progress, so a new day has started).**
The game could not read the day you had in progress, so it started a new day. Your finished days and jobs are kept. Tell the person who runs the game what you did just before the message.

**Why don't I see the 3D office?**
Your browser or device may not show 3D graphics. The title screen then shows a short reason, and the game uses a simple list of places and people to interact with instead. The game still works. To try the 3D office again:

- Open the game in **Safari**, or
- Update **Chrome** to the latest version, then reload the page. In Chrome, you can also turn on **Hardware acceleration** (Tăng tốc phần cứng) in the browser settings.

**The screen is blank or the 3D picture is missing.**
Press **🧩 Không thấy hình? Dùng chế độ đơn giản** (Can't see the picture? Use the simple mode) on the title screen. The page reloads and uses the simple list. To go back to 3D, press **🎮 Thử lại chế độ 3D** (Try 3D mode again) on the title screen.

**The game switched to a simple list in the middle of my day.**
The 3D picture stopped working, for example because the graphics system on your device reset. A short message appears, and you can keep playing from the list. To try 3D again, open the game in **Safari**, or update **Chrome** to the latest version, then reload the page.

**The start button says "Trình duyệt chưa hỗ trợ" (browser not supported). What do I do?**
Your browser is too old for the game. Open the link in **Safari**, or update **Chrome** to the latest version and reload the page.

**A box says the game is open inside an app (Zalo, Messenger…). What do I do?**
Chat apps often hide the 3D picture. Tap the **⋯** button and choose **Mở bằng trình duyệt** (Open in browser). Then continue in **Safari** (iPhone or Mac), or in the updated **Chrome** (Android or Windows).

**The game says it could not start. What do I do?**
Check the following: open the game in **Safari**, or update **Chrome** to the latest version; if you are inside Zalo or Messenger, choose "Mở bằng trình duyệt"; check your internet connection and reload the page. You only need the connection the first time when you open `index.html`.

**How do I turn off the sound?**
Press **M**, or tap the 🔊 button at the top right. Press again to turn it back on.

**How do I change how close the camera is?**
Tap the **🎥** button at the top right. It cycles through close (Gần), medium (Vừa), and far (Xa). Your choice is remembered.

**The text is too small or the buttons overlap on my phone.**
The layout adjusts to the screen. Try rotating your device or reloading the page.

**What do coworkers call me?**
The name you typed on the title screen. If you left it empty, they call you "bạn". Their wording also follows the gender you picked (Nam, Nữ, or Không nêu). If you signed in as a coworker, they call you by that character's name (for example "anh Bảo" or "chị Ba"), see **Signing in**. If you are the coworker Bảo, the lines that would say "bạn" to you say "anh" instead.

**I want to start over.**
Use **Xóa dữ liệu** (Delete data) on the title screen. This removes all saved progress.

**Where is the front door?**
On the right-hand wall, in the middle of the office. You start the day right next to it, and coworkers come in and go out through it.

**Can I skip ahead?**
Yes. Open the pause menu (P or ⏸) and choose "Bỏ qua tới …" to jump to the next milestone. You can also use ⏩ to speed up time.

**What happens at 6 pm?**
The workday ends. Your coworkers say goodbye and go home one by one while the camera turns slowly around the office. Toàn stays late. When the scene ends, you choose when to go home. Your day is then written to the diary, as usual.

**Does the game end?**
No. There is no ending. Keep playing day after day for as long as you like. The title screen shows how many days you have worked.

**Can I play more than one day in a row?**
Yes. After the summary, choose "☀ Sang ngày tiếp theo" (Go to the next day). On Friday, a weekend note comes first.

**Why does the day sometimes look different?**
Each day has a type (normal, rainy, busy, relaxed, or milk tea), 3 or 4 random surprises, one daily event (printer jam or cake party), and sometimes a coworker's birthday cake party. A random coworker may also ask for help. Coworker behavior varies a little from day to day.

**What happens if I quit in the middle of a day?**
The day is kept in progress. Choose **▶ Tiếp tục ngày đang dở** on the title screen to carry on. The day is written to the diary only when it ends. Choosing **🔄 Bắt đầu lại ngày này** (Start this day again) on the title screen throws the saved day away and starts over at 08:30.

**Why doesn't today show in my diary yet?**
Diary entries are written at the end of the day, after the summary. Until then, the diary shows the day you are on but no entry for it. On your first day, the diary says so.

**What is the App Dating version?**
It is the version of the app in the game. It goes up each week, and the Monday meeting is about the next version.

**What does "bánh tét" mean?**
It is a teasing nickname. Chị Ba uses it for Chú 7, the QC coworker. It is a joke between colleagues and nothing more.

**Is there a Vietnamese and English version?**
The game is in Vietnamese only.

**Why isn't Nguyên in the office?**
He often works from home. He comes into the office on about half of the days. When he does, a short message appears shortly after he arrives. He works at his desk on the right-hand table, with one short nap on the daybed after lunch.

**Where do I see everything I need to do today?**
Tap the goal box at the top of the screen, or press P. The pause menu shows the day's milestones and small tasks. Press **▶ Tiếp tục** to go back.

**Can I stop a job halfway through?**
Yes. Press **⏸ Tạm dừng (giữ nguyên tiến độ)** (Pause, keep progress) or **Để lát nữa (không mất gì)** (Later, nothing is lost). When you go back to your desk, the same job is waiting with your progress kept. The job is cleared when you finish it or when a new day starts. Closing the game or reloading the page keeps the unfinished job with your progress, like the rest of the day (see **Saving your day**). Pop-up cards close when you reload.

**I am stuck on a job. What do I do?**
Each wrong tap shows a hint. After two wrong taps, the game outlines the right answer: the right group, or the job with the nearest deadline.

**How do I find my desk?**
Look for the yellow label "💻 Bàn của bạn" above your desk. If the desk is off-screen to one side, the label sticks to that side of the screen. The label goes away once you have finished your three jobs for the day, and while you are sitting at your desk.

**What happens after I finish a job?**
The coworker who asked you for help thanks you, and you grow a little closer to them.

**Who is "bé Hạnh"?**
It is a playful nickname. Nam uses it to tease Chủ tịt (Thạnh). When he talks about work, he calls him "Thạnh".

**Why is there a cup on a coworker's desk?**
That is the drink Chủ tịt bought for the team. Coworkers who did not come to the pantry get theirs at their desk, and it stays there for a while. Coworkers who came to the pantry carry their cup back to their desk. Anh Bảo's desk always has an iced black coffee.

**Why do some coworkers have titles, like Anh Bảo or Chủ tịt?**
Most coworkers use first names. The titles are part of how the team talks to each other. Chủ tịt is the name everyone uses for the leader who hosts the meeting.
