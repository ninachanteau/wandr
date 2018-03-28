
import "bootstrap";
import "../plugins/flatpickr";

import "../components/sidebar";

import "../components/back_cards";

import {RefreshForm} from "../components/form_url";
RefreshForm();

import { autocomplete } from '../components/autocomplete';
autocomplete();

import { displayCalendar } from '../plugins/fullcalendar';
displayCalendar();
