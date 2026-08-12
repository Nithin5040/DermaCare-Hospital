-- ========================================================
-- SUPABASE POSTGRESQL SCHEMA FOR DERMA GLOW CLINIC & HOSPITAL
-- ========================================================
-- Execute this script in your Supabase SQL Editor:
-- https://app.supabase.com/project/_/sql

-- 1. Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. USERS TABLE
CREATE TABLE IF NOT EXISTS public.users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    role VARCHAR(20) DEFAULT 'patient', -- 'patient', 'doctor', 'admin'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. DOCTORS TABLE
CREATE TABLE IF NOT EXISTS public.doctors (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    specialty VARCHAR(255) NOT NULL,
    qualifications VARCHAR(255),
    experience_years INT DEFAULT 5,
    avatar_url TEXT,
    bio TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. APPOINTMENTS TABLE
CREATE TABLE IF NOT EXISTS public.appointments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    patient_name VARCHAR(255) NOT NULL,
    patient_email VARCHAR(255) NOT NULL,
    patient_phone VARCHAR(50) NOT NULL,
    age INT,
    gender VARCHAR(20),
    skin_concern VARCHAR(255) NOT NULL,
    doctor_id UUID REFERENCES public.doctors(id) ON DELETE SET NULL,
    doctor_name VARCHAR(255),
    appointment_date DATE NOT NULL,
    appointment_time VARCHAR(20) NOT NULL,
    notes TEXT,
    
    -- Selfie & Image Storage (Base64 or Supabase Storage Public URL)
    selfie_url TEXT NOT NULL,
    
    -- Geolocation Exact Coordinates
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    location_address TEXT,
    
    status VARCHAR(50) DEFAULT 'Confirmed', -- 'Pending', 'Confirmed', 'Completed', 'Cancelled'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. INSERT INITIAL DERMATOLOGY DOCTORS
INSERT INTO public.doctors (name, specialty, qualifications, experience_years, avatar_url, bio)
VALUES 
('Dr. Ananya Deshmukh', 'Aesthetic Dermatology & Laser Therapy', 'MD (AIIMS New Delhi), FRCP', 14, 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=400&auto=format&fit=crop', 'Specialized in facial rejuvenation, acne scar removal, and advanced glow lasers.'),
('Dr. Rajesh Iyer', 'Clinical Dermatology & Hair Restoration', 'MD, DNB (BMCRI Bengaluru)', 12, 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=400&auto=format&fit=crop', 'Expert in complex skin conditions, scalp rejuvenation, and anti-pigmentation care.'),
('Dr. Sunita Rao', 'Pediatric & Cosmetic Skin Care', 'MD Dermatology (Manipal University)', 9, 'https://images.unsplash.com/photo-1651008376811-b90baee60c1f?q=80&w=400&auto=format&fit=crop', 'Focuses on holistic skin health, collagen restoration, and sensitive skin solutions.'),
('Dr. Vikramaditya Kulkarni', 'Laser Resurfacing & Anti-Aging', 'MD (St. John''s Medical College)', 15, 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=400&auto=format&fit=crop', 'Pioneer in non-surgical skin lifting, dermal fillers, and precision laser skin tightening.')
ON CONFLICT DO NOTHING;

-- 6. INSERT INITIAL PATIENT USER
INSERT INTO public.users (full_name, email, password_hash, phone, role)
VALUES ('Shreeya Shetty', 'shreeyashetty489@gmail.com', 'Leo@0489', '+1 555-0198', 'patient')
ON CONFLICT (email) DO UPDATE SET password_hash = 'Leo@0489';

-- 6. ENABLE ROW LEVEL SECURITY (RLS)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.doctors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;

-- Create public read policies for doctors & appointments for demo app compatibility
CREATE POLICY "Allow public read doctors" ON public.doctors FOR SELECT USING (true);
CREATE POLICY "Allow public all appointments" ON public.appointments FOR ALL USING (true);
CREATE POLICY "Allow public all users" ON public.users FOR ALL USING (true);

-- 7. SUPABASE STORAGE BUCKET FOR SELFIES (Optional if storing URLs)
-- Run this if using Supabase Storage UI:
-- Insert into storage.buckets (id, name, public) values ('selfies', 'selfies', true);
