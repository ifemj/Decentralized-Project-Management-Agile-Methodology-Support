# Decentralized Project Management with Agile Methodology Support

A comprehensive blockchain-based project management system built on Clarity smart contracts, designed to support agile development methodologies in a decentralized environment.

## Overview

This system provides a complete suite of smart contracts for managing agile projects, including coach verification, sprint management, backlog coordination, velocity tracking, and retrospective management.

## Features

### 🏆 Agile Coach Verification
- Register and verify agile methodology coaches
- Track certifications and experience
- Ensure only qualified coaches facilitate agile processes

### 🏃‍♂️ Sprint Management
- Create and manage sprint cycles
- Track sprint goals and duration
- Manage sprint tasks and assignments
- Monitor sprint progress and completion

### 📋 Backlog Coordination
- Create and manage project backlogs
- Prioritize backlog items
- Assign story points
- Link backlog items to sprints

### 📊 Velocity Tracking
- Track team velocity across sprints
- Calculate completion percentages
- Monitor team performance metrics
- Support capacity planning

### 🔄 Retrospective Management
- Facilitate sprint retrospectives
- Collect team feedback (went well, improve, actions)
- Vote on retrospective items
- Create and track action items

## Smart Contracts

### 1. Agile Coach Verification (`agile-coach-verification.clar`)
Manages the registration and verification of agile coaches.

**Key Functions:**
- `register-coach`: Register a new coach
- `verify-coach`: Verify a coach's credentials
- `is-verified-coach`: Check if an address is a verified coach

### 2. Sprint Management (`sprint-management.clar`)
Handles sprint lifecycle and task management.

**Key Functions:**
- `create-sprint`: Create a new sprint
- `start-sprint`: Start a sprint
- `complete-sprint`: Complete a sprint
- `add-task-to-sprint`: Add tasks to sprints
- `update-task-status`: Update task status

### 3. Backlog Coordination (`backlog-coordination.clar`)
Manages project backlogs and item prioritization.

**Key Functions:**
- `create-backlog`: Create a new project backlog
- `add-backlog-item`: Add items to backlog
- `update-item-priority`: Update item priority
- `assign-to-sprint`: Assign items to sprints

### 4. Velocity Tracking (`velocity-tracking.clar`)
Tracks team performance and velocity metrics.

**Key Functions:**
- `create-team`: Create a new team
- `record-velocity`: Record sprint velocity data
- `get-velocity-percentage`: Calculate velocity percentage

### 5. Retrospective Management (`retrospective-management.clar`)
Facilitates sprint retrospectives and action item tracking.

**Key Functions:**
- `create-retrospective`: Create a new retrospective
- `add-retro-item`: Add retrospective items
- `vote-on-item`: Vote on retrospective items
- `create-action-item`: Create action items

## Getting Started

### Prerequisites
- Clarity development environment
- Stacks blockchain testnet access

### Installation

1. Clone the repository
2. Deploy contracts to your preferred Stacks network
3. Initialize with your project data

### Usage Example

```clarity
;; Register as an agile coach
(contract-call? .agile-coach-verification register-coach "John Doe" "Certified Scrum Master" u5)

;; Create a project backlog
(contract-call? .backlog-coordination create-backlog "My Project" "Project description")

;; Create a sprint
(contract-call? .sprint-management create-sprint u1 "Sprint 1" u1000 "Implement user authentication")

;; Add backlog item
(contract-call? .backlog-coordination add-backlog-item u1 "User login" "Implement user login functionality" u1 u8)
