import { Component } from '@angular/core';
import {ContactComponent} from './contact/contact.component'

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [ContactComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {}
