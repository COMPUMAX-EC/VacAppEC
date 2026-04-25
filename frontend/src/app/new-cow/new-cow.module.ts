import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IonicModule } from '@ionic/angular';

import { NewCowPageRoutingModule } from './new-cow-routing.module';

import { NewCowPage } from './new-cow.page';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    NewCowPageRoutingModule,
    ReactiveFormsModule
  ],
  declarations: [NewCowPage]
})
export class NewCowPageModule {}
