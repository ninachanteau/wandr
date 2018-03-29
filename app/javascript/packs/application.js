import "bootstrap";

import "../components/sidebar";
import "../components/select_participant";
import { RefreshForm } from "../components/form_url";
import { displayCalendar } from '../plugins/fullcalendar';
import { loadTooltips } from '../components/tooltip';

RefreshForm();
displayCalendar();
loadTooltips();

// import {selectParticipant} from "../components/select_participant";
// selectParticipant();
