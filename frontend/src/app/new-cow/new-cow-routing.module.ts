import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { NewCowPage } from './new-cow.page';

const routes: Routes = [
  {
    path: '',
    component: NewCowPage
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class NewCowPageRoutingModule {}
