# Airbnb Premium Listings – Flutter Frontend

**Author:** Areesha Majid  
**Tech Stack:** Flutter (Dart) · Node.js · Express · CSV Data

---

## Project Overview

This is the Flutter frontend for the Airbnb Premium Listings project. It connects to a Node.js backend API that loads real Airbnb listing data from 4 Australian states and returns premium-ranked listings based on a custom scoring algorithm.

The frontend allows users to filter listings by state and toggle a jurisdiction filter on or off, displaying results in a clean, scrollable card-based UI.

---

## Problem Statement

Modern short-term rental platforms like Airbnb operate across multiple legal jurisdictions, each with its own regulations around which properties can be listed and promoted. A key challenge for these platforms is ensuring that only **compliant, high-quality listings** are surfaced to users in specific regions.

This project addresses that challenge by implementing a **jurisdiction-based filtering system** for Airbnb listings across 4 Australian states — Victoria, New South Wales, Queensland, and South Australia.

The goal was to:
- Build a **Node.js backend** that loads real Airbnb CSV data, ranks listings by a custom premium score, and exposes a filtered API
- Build a **Flutter frontend** that connects to the backend and lets users explore listings by state with a jurisdiction toggle

This simulates a real-world compliance scenario where a backend gatekeeper controls which listings are visible based on approved jurisdictions.
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
