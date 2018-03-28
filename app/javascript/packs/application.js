
import "bootstrap";
import "../plugins/flatpickr";

import "../components/sidebar";
import "../components/select_participant";

import {RefreshForm} from "../components/form_url";
RefreshForm();

import { autocomplete } from '../components/autocomplete';
autocomplete();

import { displayCalendar } from '../plugins/fullcalendar';
displayCalendar();

import {selectParticipant} from "../components/select_participant";
selectParticipant();
