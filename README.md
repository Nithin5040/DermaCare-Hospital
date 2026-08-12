# 🏥 DermaCare Skin Care Hospital Application

A complete full-stack web application for a luxury Dermatology & Skin Care Hospital with user authentication, live camera selfie snapshot diagnostic upload, exact GPS geolocation (Latitude/Longitude) tracking, Node.js REST API, and Supabase PostgreSQL database integration.

---

## 📁 Repository Structure

```
├── index.html            👈 Standalone 1-File React App (Open directly in browser or host on Vercel)
├── supabase.sql          👈 Database SQL schema script for Supabase
├── backend/              👈 Node.js + Express REST API (Configured for Render deployment)
│   ├── server.js
│   ├── package.json
│   ├── render.yaml       👈 Render 1-click blueprint
│   └── .env.example
├── frontend/             👈 React + Vite + Tailwind project (Configured for Vercel deployment)
│   ├── src/
│   │   ├── App.jsx
│   │   ├── main.jsx
│   │   └── index.css
│   ├── package.json
│   ├── vite.config.js
│   └── vercel.json
└── README.md
```

---

## 🚀 Deployment Guide

### 1. Database Setup (Supabase)
1. Log in to [Supabase Console](https://app.supabase.com/) and create a new project.
2. Open the **SQL Editor** tab in your Supabase dashboard.
3. Copy the contents of `supabase.sql` and click **Run**.
4. Copy your **Supabase URL** and **Anon API Key** from Project Settings -> API.

---

### 2. Backend API Deployment (Render)
1. Log in to [Render Console](https://dashboard.render.com/).
2. Click **New +** -> **Web Service** and connect your repository (or upload `backend/`).
3. Set the following settings:
   - **Root Directory**: `backend`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
4. Add Environment Variables:
   - `SUPABASE_URL`: `https://your-project-id.supabase.co`
   - `SUPABASE_KEY`: `your-supabase-anon-key`
   - `PORT`: `5000`
5. Click **Deploy Web Service**. Render will generate your live backend URL (e.g. `https://skincare-api.onrender.com`).

---

### 3. Frontend Deployment (Vercel)

#### Option A: Quick Standalone HTML Deployment
1. Log in to [Vercel](https://vercel.com).
2. Deploy the root directory containing `index.html`. Vercel will instantly host it as a high-performance single page application!

#### Option B: Vite React Project Deployment
1. Import your project into Vercel and set Root Directory to `frontend`.
2. Environment Variables:
   - `VITE_API_URL`: `https://skincare-api.onrender.com` (Your Render backend URL)
3. Click **Deploy**.

---

## 💻 Local Quick Start

### Running the Standalone Single HTML App:
Double-click `index.html` or open it directly in any browser (Chrome, Edge, Firefox, Safari).

### Running Node.js Backend Locally:
```bash
cd backend
npm install
npm run dev
```
The API server will run at `http://localhost:5000`.

### Running React Frontend Locally:
```bash
cd frontend
npm install
npm run dev
```
The React development server will start at `http://localhost:3000`.

---

## ✨ Features Included

1. **Luxury Dermatology Aesthetic**: Curated color tokens (Teal, Gold, Soft Cream, Emerald), glassmorphism, responsive grid layout.
2. **User Authentication**: Login & Sign Up flow with session persistence.
3. **Live Selfie Snapshot**: Accesses webcam using `navigator.mediaDevices.getUserMedia`, captures base64 photo for dermatological assessment with retake option.
4. **Exact Lat/Long Geolocation**: Accesses HTML5 GPS API (`navigator.geolocation.getCurrentPosition`) down to high-precision decimal coordinates.
5. **Database Dashboard**: View booked appointments, preview selfie photos, inspect exact latitude & longitude with direct Google Maps pin links.
