-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 30 أغسطس 2026 الساعة 22:35
-- إصدار الخادم: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `underemergency`
--

-- --------------------------------------------------------

--
-- بنية الجدول `ai_assessments`
--

CREATE TABLE `ai_assessments` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `triage_level` varchar(50) DEFAULT NULL,
  `classification` varchar(100) DEFAULT NULL,
  `confidence_score` decimal(5,2) DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `recommendation` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- RELATIONSHIPS FOR TABLE `ai_assessments`:
--   `assessment_id`
--       `assessments` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `ai_assessments`
--

INSERT INTO `ai_assessments` (`id`, `assessment_id`, `triage_level`, `classification`, `confidence_score`, `summary`, `recommendation`, `created_at`) VALUES
(1, 1, 'MILD', 'MINOR_INJURY', 94.50, 'Small superficial hand cut with mild bleeding and mild pain. No indicators of a critical emergency were identified.', 'Basic wound care and OTC pain relief may be considered. Healthcare provider review recommended.', '2026-08-30 19:34:35');

-- --------------------------------------------------------

--
-- بنية الجدول `assessments`
--

CREATE TABLE `assessments` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `pain_level` varchar(30) DEFAULT NULL,
  `injury_time` datetime DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `assessments`:
--   `patient_id`
--       `patients` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `assessments`
--

INSERT INTO `assessments` (`id`, `patient_id`, `description`, `pain_level`, `injury_time`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Small cut on the hand while cutting vegetables in the kitchen.', 'Mild', '2026-08-30 18:45:00', 'PROVIDER_REVIEWED', '2026-08-30 19:32:21', '2026-08-30 19:32:21');

-- --------------------------------------------------------

--
-- بنية الجدول `assessment_media`
--

CREATE TABLE `assessment_media` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `media_type` varchar(50) DEFAULT NULL,
  `file_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `assessment_media`:
--   `assessment_id`
--       `assessments` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `assessment_media`
--

INSERT INTO `assessment_media` (`id`, `assessment_id`, `media_type`, `file_url`, `created_at`) VALUES
(1, 1, 'IMAGE', 'demo/hand_cut.jpg', '2026-08-30 19:33:59'),
(2, 1, 'VOICE', 'demo/patient_voice.m4a', '2026-08-30 19:33:59');

-- --------------------------------------------------------

--
-- بنية الجدول `assessment_symptoms`
--

CREATE TABLE `assessment_symptoms` (
  `assessment_id` int(11) NOT NULL,
  `symptom_id` int(11) NOT NULL,
  `severity` varchar(30) DEFAULT NULL
) ;

--
-- RELATIONSHIPS FOR TABLE `assessment_symptoms`:
--   `assessment_id`
--       `assessments` -> `id`
--   `symptom_id`
--       `symptoms` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `assessment_symptoms`
--

INSERT INTO `assessment_symptoms` (`assessment_id`, `symptom_id`, `severity`) VALUES
(1, 1, 'Mild'),
(1, 2, 'Mild'),
(1, 3, 'Mild');

-- --------------------------------------------------------

--
-- بنية الجدول `assessment_timeline`
--

CREATE TABLE `assessment_timeline` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `actor_id` int(11) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `assessment_timeline`:
--   `actor_id`
--       `users` -> `id`
--   `assessment_id`
--       `assessments` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `assessment_timeline`
--

INSERT INTO `assessment_timeline` (`id`, `assessment_id`, `actor_id`, `action`, `description`, `created_at`) VALUES
(1, 1, 1, 'ASSESSMENT_CREATED', 'Patient created a new injury assessment.', '2026-08-30 19:43:59'),
(2, 1, 1, 'MEDIA_UPLOADED', 'Patient uploaded an image and voice description.', '2026-08-30 19:43:59'),
(3, 1, NULL, 'AI_ANALYSIS_COMPLETED', 'AI completed the initial triage assessment.', '2026-08-30 19:43:59'),
(4, 1, NULL, 'SENT_TO_PROVIDER', 'Assessment was sent to a healthcare provider for review.', '2026-08-30 19:43:59'),
(5, 1, 2, 'PROVIDER_REVIEWED', 'Healthcare provider reviewed the AI assessment.', '2026-08-30 19:43:59'),
(6, 1, 2, 'AI_ASSESSMENT_CONFIRMED', 'Healthcare provider confirmed the AI assessment.', '2026-08-30 19:43:59'),
(7, 1, 2, 'FINAL_TRIAGE_CREATED', 'Final triage decision was recorded.', '2026-08-30 19:43:59'),
(8, 1, NULL, 'FACILITY_ASSIGNED', 'Healthcare facility was assigned to the patient.', '2026-08-30 19:43:59'),
(9, 1, NULL, 'ENTRY_TIME_SCHEDULED', 'Emergency department entry time was scheduled.', '2026-08-30 19:43:59');

-- --------------------------------------------------------

--
-- بنية الجدول `facility_availability`
--

CREATE TABLE `facility_availability` (
  `id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  `wait_time_minutes` int(11) DEFAULT NULL,
  `capacity_status` varchar(50) DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- RELATIONSHIPS FOR TABLE `facility_availability`:
--   `facility_id`
--       `healthcare_facilities` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `facility_availability`
--

INSERT INTO `facility_availability` (`id`, `facility_id`, `wait_time_minutes`, `capacity_status`, `recorded_at`) VALUES
(1, 1, 10, 'LOW', '2026-08-30 19:39:31');

-- --------------------------------------------------------

--
-- بنية الجدول `facility_entries`
--

CREATE TABLE `facility_entries` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  `scheduled_time` datetime DEFAULT NULL,
  `arrival_from` datetime DEFAULT NULL,
  `arrival_until` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `facility_entries`:
--   `assessment_id`
--       `assessments` -> `id`
--   `facility_id`
--       `healthcare_facilities` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `facility_entries`
--

INSERT INTO `facility_entries` (`id`, `assessment_id`, `facility_id`, `scheduled_time`, `arrival_from`, `arrival_until`, `status`, `created_at`) VALUES
(1, 1, 1, '2026-08-30 21:30:00', '2026-08-30 21:25:00', '2026-08-30 21:30:00', 'SCHEDULED', '2026-08-30 19:39:55');

-- --------------------------------------------------------

--
-- بنية الجدول `final_triage`
--

CREATE TABLE `final_triage` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `provider_review_id` int(11) DEFAULT NULL,
  `triage_level` varchar(50) DEFAULT NULL,
  `final_classification` varchar(100) DEFAULT NULL,
  `final_recommendation` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `final_triage`:
--   `assessment_id`
--       `assessments` -> `id`
--   `provider_review_id`
--       `provider_reviews` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `final_triage`
--

INSERT INTO `final_triage` (`id`, `assessment_id`, `provider_review_id`, `triage_level`, `final_classification`, `final_recommendation`, `created_at`) VALUES
(1, 1, 1, 'MILD', 'MINOR_INJURY', 'Basic wound care. Consider appropriate OTC pain relief. Attend the assigned healthcare facility at the scheduled entry time.', '2026-08-30 19:36:09');

-- --------------------------------------------------------

--
-- بنية الجدول `healthcare_facilities`
--

CREATE TABLE `healthcare_facilities` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `healthcare_facilities`:
--

--
-- إرجاع أو استيراد بيانات الجدول `healthcare_facilities`
--

INSERT INTO `healthcare_facilities` (`id`, `name`, `type`, `address`, `city`, `latitude`, `longitude`, `phone`, `created_at`) VALUES
(1, 'Central Emergency Hospital', 'Emergency Department', 'King Fahd Road', 'Riyadh', 24.7136000, 46.6753000, '0110000000', '2026-08-30 19:29:00');

-- --------------------------------------------------------

--
-- بنية الجدول `healthcare_provider`
--

CREATE TABLE `healthcare_provider` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `license_number` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `facility_id` int(11) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `healthcare_provider`:
--   `facility_id`
--       `healthcare_facilities` -> `id`
--   `user_id`
--       `users` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `healthcare_provider`
--

INSERT INTO `healthcare_provider` (`id`, `user_id`, `license_number`, `specialization`, `facility_id`, `is_available`, `created_at`) VALUES
(1, 2, 'LIC-2026-001', 'Emergency Medicine', 1, 1, '2026-08-30 19:30:58');

-- --------------------------------------------------------

--
-- بنية الجدول `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `emergency_contact` varchar(30) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `patients`:
--   `user_id`
--       `users` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `patients`
--

INSERT INTO `patients` (`id`, `user_id`, `date_of_birth`, `gender`, `emergency_contact`, `created_at`) VALUES
(1, 1, '2000-05-15', 'Male', '0500000010', '2026-08-30 19:29:44');

-- --------------------------------------------------------

--
-- بنية الجدول `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `prescriptions`:
--   `assessment_id`
--       `assessments` -> `id`
--   `provider_id`
--       `healthcare_provider` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `assessment_id`, `provider_id`, `status`, `created_at`) VALUES
(1, 1, 1, 'ACTIVE', '2026-08-30 19:41:01');

-- --------------------------------------------------------

--
-- بنية الجدول `prescription_items`
--

CREATE TABLE `prescription_items` (
  `id` int(11) NOT NULL,
  `prescription_id` int(11) NOT NULL,
  `medication_name` varchar(150) NOT NULL,
  `dosage` varchar(100) DEFAULT NULL,
  `frequency` varchar(100) DEFAULT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `instructions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `prescription_items`:
--   `prescription_id`
--       `prescriptions` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `prescription_items`
--

INSERT INTO `prescription_items` (`id`, `prescription_id`, `medication_name`, `dosage`, `frequency`, `duration`, `instructions`) VALUES
(1, 1, 'Paracetamol (Panadol)', '500 mg', 'As needed', 'Up to 3 days', 'Use only as directed on the product label and if appropriate for the patient.'),
(2, 1, 'Mebo Ointment', 'Topical application', 'As directed', 'As needed', 'Apply a thin layer to the affected area after appropriate wound cleaning.');

-- --------------------------------------------------------

--
-- بنية الجدول `provider_reviews`
--

CREATE TABLE `provider_reviews` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `ai_triage_level` varchar(50) DEFAULT NULL,
  `provider_decision` varchar(50) DEFAULT NULL,
  `provider_notes` text DEFAULT NULL,
  `reviewed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `provider_reviews`:
--   `assessment_id`
--       `assessments` -> `id`
--   `provider_id`
--       `healthcare_provider` -> `id`
--

--
-- إرجاع أو استيراد بيانات الجدول `provider_reviews`
--

INSERT INTO `provider_reviews` (`id`, `assessment_id`, `provider_id`, `ai_triage_level`, `provider_decision`, `provider_notes`, `reviewed_at`) VALUES
(1, 1, 1, 'MILD', 'CONFIRM', 'The AI assessment is clinically consistent with a minor hand injury. No immediate critical intervention is indicated.', '2026-08-30 19:35:17');

-- --------------------------------------------------------

--
-- بنية الجدول `symptoms`
--

CREATE TABLE `symptoms` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `default_severity` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `symptoms`:
--

--
-- إرجاع أو استيراد بيانات الجدول `symptoms`
--

INSERT INTO `symptoms` (`id`, `name`, `category`, `default_severity`) VALUES
(1, 'Hand Cut', 'Injury', 'Mild'),
(2, 'Mild Bleeding', 'Bleeding', 'Mild'),
(3, 'Hand Pain', 'Pain', 'Mild'),
(4, 'Swelling', 'Injury', 'Mild'),
(5, 'Severe Bleeding', 'Bleeding', 'Severe'),
(6, 'Loss of Consciousness', 'Neurological', 'Severe'),
(7, 'Chest Pain', 'Cardiac', 'Severe'),
(8, 'Difficulty Breathing', 'Respiratory', 'Severe');

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `users`:
--

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password_hash`, `role`, `created_at`) VALUES
(1, 'Ahmed Ali', 'ahmed.patient@example.com', '0500000001', 'demo_hash_001', 'PATIENT', '2026-08-30 19:27:37'),
(2, 'Dr. Sara Hassan', 'sara.provider@example.com', '0500000002', 'demo_hash_002', 'HEALTHCARE_PROVIDER', '2026-08-30 19:27:37'),
(3, 'Under Emergency Admin', 'admin@example.com', '0500000003', 'demo_hash_003', 'ADMIN', '2026-08-30 19:27:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_assessments`
--
ALTER TABLE `ai_assessments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_id` (`assessment_id`);

--
-- Indexes for table `assessments`
--
ALTER TABLE `assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assessments_patient` (`patient_id`);

--
-- Indexes for table `assessment_media`
--
ALTER TABLE `assessment_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assessment_media_assessment` (`assessment_id`);

--
-- Indexes for table `assessment_symptoms`
--
ALTER TABLE `assessment_symptoms`
  ADD PRIMARY KEY (`assessment_id`,`symptom_id`),
  ADD KEY `fk_assessment_symptoms_symptom` (`symptom_id`);

--
-- Indexes for table `assessment_timeline`
--
ALTER TABLE `assessment_timeline`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_timeline_assessment` (`assessment_id`),
  ADD KEY `fk_timeline_actor` (`actor_id`);

--
-- Indexes for table `facility_availability`
--
ALTER TABLE `facility_availability`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_facility_availability_facility` (`facility_id`);

--
-- Indexes for table `facility_entries`
--
ALTER TABLE `facility_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_facility_entries_assessment` (`assessment_id`),
  ADD KEY `fk_facility_entries_facility` (`facility_id`);

--
-- Indexes for table `final_triage`
--
ALTER TABLE `final_triage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `assessment_id` (`assessment_id`),
  ADD KEY `fk_final_triage_review` (`provider_review_id`);

--
-- Indexes for table `healthcare_facilities`
--
ALTER TABLE `healthcare_facilities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `healthcare_provider`
--
ALTER TABLE `healthcare_provider`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `unique_provider_license` (`license_number`),
  ADD KEY `fk_provider_facility` (`facility_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_prescriptions_assessment` (`assessment_id`),
  ADD KEY `fk_prescriptions_provider` (`provider_id`);

--
-- Indexes for table `prescription_items`
--
ALTER TABLE `prescription_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_prescription_items_prescription` (`prescription_id`);

--
-- Indexes for table `provider_reviews`
--
ALTER TABLE `provider_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_provider_reviews_assessment` (`assessment_id`),
  ADD KEY `fk_provider_reviews_provider` (`provider_id`);

--
-- Indexes for table `symptoms`
--
ALTER TABLE `symptoms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `unique_user_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_assessments`
--
ALTER TABLE `ai_assessments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assessments`
--
ALTER TABLE `assessments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `assessment_media`
--
ALTER TABLE `assessment_media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `assessment_timeline`
--
ALTER TABLE `assessment_timeline`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `facility_availability`
--
ALTER TABLE `facility_availability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `facility_entries`
--
ALTER TABLE `facility_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `final_triage`
--
ALTER TABLE `final_triage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `healthcare_facilities`
--
ALTER TABLE `healthcare_facilities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `healthcare_provider`
--
ALTER TABLE `healthcare_provider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prescription_items`
--
ALTER TABLE `prescription_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `provider_reviews`
--
ALTER TABLE `provider_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `symptoms`
--
ALTER TABLE `symptoms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- قيود الجداول المُلقاة.
--

--
-- قيود الجداول `ai_assessments`
--
ALTER TABLE `ai_assessments`
  ADD CONSTRAINT `fk_ai_assessments_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `assessments`
--
ALTER TABLE `assessments`
  ADD CONSTRAINT `fk_assessments_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `assessment_media`
--
ALTER TABLE `assessment_media`
  ADD CONSTRAINT `fk_assessment_media_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `assessment_symptoms`
--
ALTER TABLE `assessment_symptoms`
  ADD CONSTRAINT `fk_assessment_symptoms_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_assessment_symptoms_symptom` FOREIGN KEY (`symptom_id`) REFERENCES `symptoms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `assessment_timeline`
--
ALTER TABLE `assessment_timeline`
  ADD CONSTRAINT `fk_timeline_actor` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_timeline_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `facility_availability`
--
ALTER TABLE `facility_availability`
  ADD CONSTRAINT `fk_facility_availability_facility` FOREIGN KEY (`facility_id`) REFERENCES `healthcare_facilities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `facility_entries`
--
ALTER TABLE `facility_entries`
  ADD CONSTRAINT `fk_facility_entries_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_facility_entries_facility` FOREIGN KEY (`facility_id`) REFERENCES `healthcare_facilities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `final_triage`
--
ALTER TABLE `final_triage`
  ADD CONSTRAINT `fk_final_triage_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_final_triage_review` FOREIGN KEY (`provider_review_id`) REFERENCES `provider_reviews` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `healthcare_provider`
--
ALTER TABLE `healthcare_provider`
  ADD CONSTRAINT `fk_provider_facility` FOREIGN KEY (`facility_id`) REFERENCES `healthcare_facilities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_provider_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `fk_patients_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `fk_prescriptions_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prescriptions_provider` FOREIGN KEY (`provider_id`) REFERENCES `healthcare_provider` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `prescription_items`
--
ALTER TABLE `prescription_items`
  ADD CONSTRAINT `fk_prescription_items_prescription` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `provider_reviews`
--
ALTER TABLE `provider_reviews`
  ADD CONSTRAINT `fk_provider_reviews_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_provider_reviews_provider` FOREIGN KEY (`provider_id`) REFERENCES `healthcare_provider` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
