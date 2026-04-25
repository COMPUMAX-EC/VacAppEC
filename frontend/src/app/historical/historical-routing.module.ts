import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { HistoricalPage } from './historical.page';

const routes: Routes = [
  {
    path: '',
    component: HistoricalPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class HistoricalPageRoutingModule {}
