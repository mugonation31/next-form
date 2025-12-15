import os 
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr
from dotenv import load_dotenv
from supabase import create_client, Client

# Load environment variables 
load_dotenv()

# Initialise FastAPI
app = FastAPI(
    title="next-form",
    description="API for next-form",
    version="1.0.0"
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:4200", # Angular dev 
        "http://localhost",      # Docker production
        "http://localhost:80"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialise Supabase client
supabase: Client = create_client(
    os.getenv("SUPABASE_URL"),
    os.getenv("SUPABASE_SERVICE_ROLE_KEY")
)

# Data Models (Pydantic)
class NextForm(BaseModel):
    """Model for next form submission"""
    name: str
    surname: str
    email: EmailStr
    message: str

#API Endpoints
@app.get("/")
def read_root():
    """Welcome endpoint"""
    return {
        "message": "Welcome to Next Form App API",
        "version": "1.0.0"
    }

@app.get("/healthy")
def health_check():
    """Health check endpoint"""
    return {"status": "OK"}

@app.get("/api/contact") 
def options_next_form():
    """
    Handle CORS preflight requests for the option_next_form endpoint
    """
    return{"message": "OK"}

@app.post("/api/contact")
def submit_next_form(form_data: NextForm):
    """
    Endpoint to receive next form submission and save to supabe 
    """
    try:
        #Save to Supabse
        data = {
            "name": form_data.name,
            "surname": form_data.surname,
            "email": form_data.email,
            "message": form_data.message
        }

        result = supabase.table("contacts").insert(data).execute()

        print(f"Received contact form from: {form_data.name} {form_data.surname}")
        print(f"Email {form_data.email}")
        print(f"Saved to database with ID: {result.data[0]['id'] if result.data else 'unknown'}")

        return {
            "status": "success",
            "message": "Contact form submitted successfully",
            "data": {
                "name": form_data.name,
                "surname": form_data.surname,
                "email": form_data.email
            }
        }
    
    except Exception as e:
        print(f"Error saving contact form {(str(e))}")
        raise HTTPException(
            status_code=500,
            detail=f"Failed to save contact form {(str(e))}"
        )