# Airbnb Premium Listings – Flutter Frontend

**Author:** Areesha Majid  
**Tech Stack:** Flutter (Dart) · Node.js 

---

## Contents

1. [Problem Statement](#problem-statement)
2. [Project Overview](#project-overview)
3. [Features](#features)
4. [How to Run](#how-to-run)
5. [API Endpoints](#api-endpoints)
6. [Challenges Faced](#challenges-faced)
7. [References](#references)

---
## Problem Statement

Modern short-term rental platforms like Airbnb operate across multiple legal jurisdictions, each with its own regulations around which properties can be listed and promoted. A key challenge for these platforms is ensuring that only **compliant, high-quality listings** are surfaced to users in specific regions.

This project addresses that challenge by implementing a **jurisdiction-based filtering system** for Airbnb listings across 4 Australian states; Victoria, New South Wales, Queensland, and South Australia.

The goal was to:
- Build a **Node.js backend** that loads real Airbnb CSV data, ranks listings by a custom premium score, and exposes a filtered API
- Build a **Flutter frontend** that connects to the backend and lets users explore listings by state with a jurisdiction toggle

This simulates a real-world compliance scenario where a backend gatekeeper controls which listings are visible based on approved jurisdictions.

---

## Project Overview

This is the Flutter frontend for the Airbnb Premium Listings project. It connects to a Node.js backend API that loads real Airbnb listing data from 4 Australian states and returns premium-ranked listings based on a custom scoring algorithm.

The frontend allows users to filter listings by state and toggle a jurisdiction filter on or off, displaying results in a clean, scrollable card-based UI.

---


## Features

- Airbnb-themed UI (red color scheme)
- State dropdown: VIC, NSW, QLD, SA
- Jurisdiction toggle switch: ON/OFF
- Dynamic header text based on toggle state
- Scrollable listing cards showing:
  - Listing name
  - Neighbourhood
  - Room type
  - Price per night
  - Number of reviews
- Loading spinner while fetching
- Error message if backend is not running

---

## How to Run

### Prerequisites
- Flutter SDK installed
- Node.js installed
- Both repositories cloned


### 1. Start the Backend
```bash
cd airbnb-node-filter
node app.js
```
Server runs on `http://localhost:3000`

### 2. Start the Frontend
```bash
cd airbnb_frontend
flutter run -d chrome
```
App opens in Chrome at `localhost`

> Make sure the backend is running before clicking "Fetch Premium Listings" in the app.

---

## API Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /` | Landing page |
| `GET /listings?stateToggle=on&allowedStates=vic` | Top 20 premium VIC listings |
| `GET /listings?stateToggle=on&allowedStates=nsw` | Top 20 premium NSW listings |
| `GET /listings?stateToggle=on&allowedStates=qld` | Top 20 premium QLD listings |
| `GET /listings?stateToggle=on&allowedStates=sa` | Top 20 premium SA listings |
| `GET /listings?stateToggle=off` | Top 100 listings (no filter) |

---

## Challenges Faced

### 1. OneDrive File Locking
The Flutter project was initially created inside an OneDrive folder on the Desktop. OneDrive kept syncing files in the background, causing Flutter to fail when trying to build or delete temporary files. The fix was to move the entire project to `C:\src\airbnb_frontend`, a local folder outside OneDrive, where Flutter could read and write freely.

### 2. Corrupted Flutter SDK
The first Flutter SDK download was extracted into the wrong location and contained a nested folder structure. This caused the `flutter` command to not be recognised in PowerShell. Fixed by reorganising the folder structure and updating the Windows PATH environment variable to point to `C:\src\flutter\bin`.

### 3. CORS Error
When the Flutter web app tried to call the Node.js backend on a different port, the browser blocked the request due to CORS (Cross-Origin Resource Sharing) policy. Fixed by installing the `cors` package in the backend and adding:
```javascript
const cors = require('cors');
app.use(cors());
```

### 4. Listing Limit
The backend was defaulting to returning 500 listings regardless of the toggle state, which caused the frontend to load too slowly. Fixed by setting smart limits:
- Toggle **ON** → top 20 premium listings per selected state
- Toggle **OFF** →  100 listings across all states

### 5. Scroll View Not Working
The listings were rendering but couldn't be scrolled. This happened because the `ListView` was inside an `Expanded` widget inside a `Column`, which constrained its height. Fixed by replacing the outer `Padding` with a `SingleChildScrollView` and using `shrinkWrap: true` with `NeverScrollableScrollPhysics()` on the `ListView`.

### 6. Pub Cache Corruption
Running `flutter create` silently failed due to a corrupted pub cache. Fixed by deleting the cache:
```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Pub\Cache"
```
Then re-running `flutter create` succeeded.

---

## References

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter HTTP Package](https://pub.dev/packages/http)
- [Flutter Material Widgets](https://docs.flutter.dev/ui/widgets/material)
- [Node.js Documentation](https://nodejs.org/en/docs)
- [Express.js Documentation](https://expressjs.com/)
- [CORS npm Package](https://www.npmjs.com/package/cors)
- [Inside Airbnb – Open Data](http://insideairbnb.com/get-the-data/)
- [Airbnb Search Ranking Algorithm](https://www.airbnb.com.au/help/article/829)
- [Airbnb Ranking Factors](https://blog.tokeet.com/airbnb-search-ranking-algorithm-rewards/)
- [Flutter Web Support](https://docs.flutter.dev/platform-integration/web)
- [Git Documentation](https://git-scm.com/doc)

## Related Repositories

- **Backend:** [airbnb-node-filter](https://github.com/areeshamajid/airbnb-node-filter)
- **Frontend:** [airbnb_frontend](https://github.com/areeshamajid/airbnb_frontend)
