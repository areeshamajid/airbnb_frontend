# Airbnb Premium Listings – Flutter Frontend

**Author:** Areesha Majid  
**Tech Stack:** Flutter (Dart) · Node.js · Express · CSV Data

---

## Project Overview

This is the Flutter frontend for the Airbnb Premium Listings project. It connects to a Node.js backend API that loads real Airbnb listing data from 4 Australian states and returns premium-ranked listings based on a custom scoring algorithm.

The frontend allows users to filter listings by state and toggle a jurisdiction filter on or off, displaying results in a clean, scrollable card-based UI.

---

## The Problem

The backend implements a **jurisdiction toggle system** that acts as a gatekeeper:
- When **ON**, it filters listings to only show premium results from a specific approved state (VIC, NSW, QLD, or SA)
- When **OFF**, it shows the top 100 listings across all states without filtering

The challenge was building a frontend that could:
1. Communicate with the Node.js backend over HTTP
2. Display the filtered results cleanly
3. Make the jurisdiction toggle visible and interactive for the user

---

## How We Fixed It

Several technical challenges were encountered and resolved:

**1. CORS Error**  
The browser blocked requests from the Flutter app (running on one port) to the Node backend (port 3000). Fixed by adding the `cors` package to the Node backend:
```javascript
const cors = require('cors');
app.use(cors());
```

**2. OneDrive File Locking**  
The Flutter project was initially inside an OneDrive folder, which caused file locking errors and prevented Flutter from building. Fixed by moving the project to `C:\src\airbnb_frontend` outside OneDrive.

**3. Listing Limit**  
The backend was defaulting to 500 listings regardless of the toggle state. Fixed by setting smart defaults:
- Toggle **ON** → top 20 premium listings per state
- Toggle **OFF** → top 100 listings across all states

**4. Scroll View**  
The listings were not scrollable initially. Fixed by wrapping the page body in a `SingleChildScrollView` and using `shrinkWrap: true` with `NeverScrollableScrollPhysics()` on the `ListView`.

---

## How to Run

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

## Related Repositories

- **Backend:** [airbnb-node-filter](https://github.com/areeshamajid/airbnb-node-filter)
- **Frontend:** [airbnb_frontend](https://github.com/areeshamajid/airbnb_frontend)
