import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormBuilder, FormGroup, Validators, EmailValidator } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { environment } from '../../environments/environment.development';


@Component({
  selector: 'app-contact',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, HttpClientModule],
  templateUrl: './contact.component.html',
  styleUrl: './contact.component.scss'
})
export class ContactComponent {
  contactForm: FormGroup;
  submitStatus: 'idle' | 'loading' | 'success' | 'error' = 'idle';
  errorMessage = '';

  constructor(
    private fb: FormBuilder,
    private http: HttpClient
  ) {
    this.contactForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(2)]],
      surname: ['', [Validators.required, Validators.minLength(2)]],
      email: ['', [Validators.required, Validators.email]],
      message: ['', [Validators.required, Validators.minLength(10)]]
    });
  }

  onSubmit() {
    if (this.contactForm.valid) {
      this.submitStatus = 'loading';

      this.http.post(`${environment.apiUrl}/api/contact`, this.contactForm.value)
        .subscribe({
          next: (response) => {
            console.log('Success:', response);
            this.submitStatus = 'success';
            this.contactForm.reset();
          },
          error: (error) => {
            console.error('Error:', error);
            this.submitStatus = 'error';
            this.errorMessage = error.error?.detail || 'Failed to submit form. Please try again.';
          }
        });
    } else {
      // Mark all fields as touched to chow validation errors
      Object.keys(this.contactForm.controls).forEach(key => {
        this.contactForm.get(key)?.markAllAsTouched();
      });
    }
  }

  // Helper methos for template 
  isFieldInvalid(fieldName: string): boolean {
    const field = this.contactForm.get(fieldName);
    return !!(field && field.invalid && field.touched);
  }

  getfieldError(fieldName: string): string {
    const field = this.contactForm.get(fieldName);
    if (field?.hasError('required')) return `${fieldName} is required`;
    if (field?.hasError('email')) return 'Invalid email format'
    if (field?.hasError('minLength')) {
      const minLength = field.errors?.['minLength'].requiredLength;
      return `Minimum ${minLength} characters required`;
    }
    return '';
  }
}
