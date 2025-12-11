-- Create contacts table 
CREATE TABLE IF NOT EXISTS public.contacts (
id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
name TEXT NOT NULL,
surname TEXT NOT NULL,
email TEXT NOT NULL,
message TEXT NOT NULL,
created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);

-- Enable Row Level Security 
ALTER TABLE public.contacts ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations (for development)
CREATE POLICY "Allow all operations" ON public.contacts
    FOR ALL
    USING (true)
    WITH CHECK (true);

-- Create index on email for faster lookups 
CREATE INDEX contacts_email_idx ON public.contacts(email);

-- Create index on created_at for sorting 
CREATE INDEX contacts_created_at_idx ON public.contacts(created_at DESC);
