# Next-Form

Full-stack contact form application with **Angular** frontend, **FastAPI** backend, and **Supabase** database.

## Tech Stack

### Frontend
- **Angular 17** - Modern web framework
- **TypeScript** - Type-safe JavaScript
- **Reactive Forms** - Form validation and management
- **SCSS** - Styling with nested CSS

### Backend
- **FastAPI** - High-performance Python web framework
- **Python 3.12** - Latest Python with type hints
- **Supabase Python Client** - Database integration
- **Uvicorn** - ASGI server

### Database
- **Supabase (PostgreSQL)** - Local development database
- **Row Level Security (RLS)** - Security policies
- **Migration system** - Version-controlled schema changes

---

## Project Structure

```
next-form/
├── backend/                    # FastAPI backend
│   ├── .venv/                 # Python virtual environment
│   ├── .env                   # Environment variables (secrets)
│   ├── main.py                # FastAPI application
│   ├── requirements.txt       # Python dependencies
│   └── supabase/              # Supabase configuration
│       ├── config.toml        # Supabase settings
│       └── migrations/        # Database migrations
│           └── 20251210234454_create_contacts_table.sql
│
├── frontend/                  # Angular frontend
│   ├── src/
│   │   ├── app/
│   │   │   ├── contact/       # Contact form component
│   │   │   │   ├── contact.component.ts
│   │   │   │   ├── contact.component.html
│   │   │   │   └── contact.component.scss
│   │   │   ├── app.component.ts
│   │   │   └── app.routes.ts
│   │   ├── environments/      # Environment configuration
│   │   │   ├── environment.ts
│   │   │   └── environment.development.ts
│   │   └── index.html
│   ├── angular.json           # Angular configuration
│   ├── package.json           # Node dependencies
│   └── tsconfig.json          # TypeScript configuration
│
└── README.md                  # This file
```

---

## Features

### Contact Form
- **Name** - First name (min 2 characters)
- **Surname** - Last name (min 2 characters)
- **Email** - Valid email address
- **Message** - Message text (min 10 characters)

### Form Validation
- Real-time field validation
- Error messages on invalid input
- Visual feedback (red borders on invalid fields)
- Submit button disabled during submission

### User Experience
- Loading state with "Sending..." message
- Success notification after submission
- Error handling with user-friendly messages
- Form automatically clears after successful submission

---

## Setup Instructions

### Prerequisites
- **Node.js** 18+ and npm
- **Python** 3.10+
- **Supabase CLI**
- **Angular CLI** (`npm install -g @angular/cli`)

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Create and activate virtual environment:**
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Start Supabase (from backend directory):**
   ```bash
   supabase start
   ```

5. **Create `.env` file with your Supabase credentials:**
   ```bash
   SUPABASE_URL=http://127.0.0.1:54321
   SUPABASE_ANON_KEY=your_anon_key_from_supabase_status
   SUPABASE_SERVICE_ROLE_KEY=your_service_role_key_from_supabase_status
   ```

6. **Run the backend server:**
   ```bash
   uvicorn main:app --reload --port 8001
   ```

   The backend will be available at: `http://localhost:8001`

### Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Start the development server:**
   ```bash
   ng serve
   ```

   The frontend will be available at: `http://localhost:4200`

---

## API Endpoints

### Backend API (http://localhost:8001)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Welcome message |
| GET | `/healthy` | Health check |
| GET | `/api/contact` | CORS preflight handler |
| POST | `/api/contact` | Submit contact form |

### POST /api/contact Request Body
```json
{
  "name": "John",
  "surname": "Doe",
  "email": "john.doe@example.com",
  "message": "This is a test message with at least 10 characters"
}
```

### Success Response (200 OK)
```json
{
  "status": "success",
  "message": "Contact form submitted successfully",
  "data": {
    "name": "John",
    "surname": "Doe",
    "email": "john.doe@example.com"
  }
}
```

---

## Database Schema

### contacts table

| Column | Type | Constraints |
|--------|------|-------------|
| id | UUID | PRIMARY KEY, auto-generated |
| name | TEXT | NOT NULL |
| surname | TEXT | NOT NULL |
| email | TEXT | NOT NULL, indexed |
| message | TEXT | NOT NULL |
| created_at | TIMESTAMP WITH TIME ZONE | NOT NULL, indexed, auto-generated |

### Indexes
- `contacts_email_idx` - Fast email lookups
- `contacts_created_at_idx` - Sorted by creation date (descending)

### Security
- Row Level Security (RLS) enabled
- Policy: "Allow all operations" (development only)

---

## Development

### View Supabase Database
Open Supabase Studio in your browser:
```
http://127.0.0.1:54323
```

### Reset Database
```bash
cd backend
supabase db reset
```

### Check Supabase Status
```bash
cd backend
supabase status
```

### Create New Migration
```bash
cd backend
supabase migration new <migration_name>
```

---

## Environment Configuration

### Development
- Backend: `http://localhost:8001`
- Frontend: `http://localhost:4200`
- Supabase: `http://127.0.0.1:54321`

### Production
Update `frontend/src/environments/environment.ts` with your production API URL.

---

## Technologies Used

### Frontend Dependencies
```json
{
  "@angular/core": "^17.3.17",
  "@angular/forms": "^17.3.17",
  "@angular/common": "^17.3.17",
  "rxjs": "~7.8.0",
  "typescript": "~5.4.2"
}
```

### Backend Dependencies
```txt
fastapi
uvicorn[standard]
pydantic[email]
python-dotenv
supabase
```

---

## Lessons Learned

Throughout this project, we learned:

1. **FastAPI Routes** - Always include leading `/` in route paths
2. **Angular Forms** - Difference between reactive and template-driven forms
3. **TypeScript** - Importance of initializing properties in constructors
4. **Database Naming** - Keep table names consistent (plural: `contacts`)
5. **CORS Configuration** - Proper setup for frontend-backend communication
6. **Environment Variables** - Secure secret management with `.env` files
7. **Form Validation** - Client-side and server-side validation patterns

---

## Testing the Application

1. Start Supabase: `cd backend && supabase start`
2. Start backend: `uvicorn main:app --reload --port 8001`
3. Start frontend: `cd frontend && ng serve`
4. Open browser: `http://localhost:4200`
5. Fill out the contact form and submit
6. Check Supabase Studio to see the saved data: `http://127.0.0.1:54323`

---

## Troubleshooting

### Backend won't start
- Check if port 8001 is available: `lsof -i :8001`
- Verify virtual environment is activated
- Check `.env` file exists with correct credentials

### Frontend won't compile
- Delete `node_modules` and run `npm install` again
- Check Angular CLI version: `ng version`
- Verify TypeScript version compatibility

### Form submission fails
- Check browser console for errors
- Verify backend is running on port 8001
- Check CORS configuration in `main.py`
- Verify Supabase is running: `supabase status`

### Database errors
- Reset database: `supabase db reset`
- Check table exists: Visit Supabase Studio
- Verify migration was applied

---

## Next Steps

Potential improvements:
- [ ] Add email notifications
- [ ] Implement rate limiting
- [ ] Add file upload capability
- [ ] Create admin dashboard to view submissions
- [ ] Deploy to production
- [ ] Add unit tests
- [ ] Add E2E tests
- [ ] Implement authentication
- [ ] Add spam protection (CAPTCHA)

---

## License

This project is for educational purposes.

---

## Acknowledgments

Built step-by-step with patience and learning in mind! 🎉
