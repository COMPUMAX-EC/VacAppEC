import { Component } from '@angular/core';
import { NewCowPage } from '../new-cow/new-cow.page';
import { RecordPage } from '../record/record.page';
import { StatsPage } from '../stats/stats.page';
import { HistoricalPage } from '../historical/historical.page';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  newCowComponent = NewCowPage;
  recordComponent = RecordPage;
  statsComponent = StatsPage;
  historicalComponent = HistoricalPage;

  constructor() {}

}
