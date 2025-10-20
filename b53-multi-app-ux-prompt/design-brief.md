## 📍 Design Brief: Desktop Multi-App Framework Shell

### 🎯 Purpose

To design a **desktop-first UX shell** capable of hosting multiple independent applications in a cohesive, intuitive interface. The system emphasizes flexibility, persistent state, and clear navigation patterns. It draws from both desktop (VS Code, Slack) and mobile-first patterns (WeChat) where appropriate, while maintaining focus on spacious, responsive desktop design.

---

### 🛡️ Core Layout Structure

#### 1. **Application Panel (Far Left)**

* **Always visible by default** like the macOS taskbar.
* **Collapsible** to a thin vertical indicator bar.

  * Hover expands temporarily.
  * Click locks it open.
* **Flat structure** with two sections:

  * **Pinned Apps** (user-defined, up to 5–8).
  * **Recent Apps** (last 3 used, excluding pinned).
* **Icons are used** to represent apps.
* At the bottom, a **global settings icon** opens a **popup menu** for system-wide configuration.
* No grouping or tagging is needed for now.

---

#### 2. **App Navigation Panel (Left-Center)**

* **Contextual panel** activated when an app is selected.
* Expanded to display readable text and app-specific menus.
* Panel content structure:

  * **Header Area** – App context or workflow title + optional short description.
  * **Dynamic Menus** – App-defined, expandable vertical navigation items.
  * **Fixed Menus** – Persistent items like "Prompts" or "Attribute Values".
  * **Footer Section** – May contain an **app-specific settings item**.

    * **App-specific settings** are conceptually distinct from global settings.
* **Breadcrumbs**, if used, are considered part of the **main panel** or above it, not the navigation panel.

---

#### 3. **Main Display Panel (Center)**

* Primary canvas for each app.
* Can support multiple interaction styles including:

  * **Wizard-style workflows** with optional top progress bars.
  * **Conversational interfaces** and trials.
  * **Forms** with structured data input.
  * **Dashboards** for data visualization and monitoring.
* Treated as a flexible container — no fixed layout types (tabs, scroll areas) are assumed.
* Layout behaviors can be implemented via **shared registered components**.

---

#### 4. **Conversational Control (Optional)**

* Treated as a **shared component**, not a fixed panel.
* Can be placed **anywhere** within an app.
* Behavior, position, and presence are defined by the **individual app**.

---

### 🔍 Command-K Interface

* Accessible via `Cmd/Ctrl + K`.
* Supports:

  * App switching/search.
  * Cross-app data search.
  * Scoped searches via tokens (e.g., `@Agent Workflow Builder`).
* **Visual preview** and search interaction model is TBD.
* For now, will launch with **mock data and placeholder interface**.

---

### 🛡️ Global Shell Components

#### Top Bar (Optional)

* May include:

  * Current app name
  * Global actions (TBD)
* Final layout/design not yet decided.

#### Footer/Status Bar (Optional)

* Currently undefined
* Likely to remain **minimalist** (e.g., sync status, user info, environment toggle)

---

### ⚙️ Shared Component System

* Framework provides a **central registry of shared components** (form fields, breadcrumbs, wizard progress, error toasts).
* Ensures design consistency and simplifies app development.
* Apps **should not bring their own components** for common UX patterns.

---

### 🗃️ App State & Data Context

* **App state is preserved** when switching between apps.
* **Live updates** across tabs are supported via Convex (used as the backend).
* Apps can be opened in **multiple browser tabs**.

  * Each tab has **isolated visual context** (no session bleeding).
* Breadcrumbs and navigation context may be implemented at the **main panel level** via shared components.

---

### 📦 App Structure & Discovery

* All apps are managed from a central **App Home**.
* No install/uninstall mechanism yet, but the framework must support **future integration of independently built apps**.
* Apps are stored as a **flat list**, with optional tags for future categorization.

---

### 🎨 Theming & Appearance

* Framework must support **light and dark modes**, along with general appearance settings.
* These settings are handled at the **system level**, not per app.
