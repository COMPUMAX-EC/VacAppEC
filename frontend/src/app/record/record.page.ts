import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CowService } from '../services/cow.service';
import Record from '../models/record';
import { RecordService } from '../services/record.service';

@Component({
  selector: 'app-record',
  templateUrl: './record.page.html',
  styleUrls: ['./record.page.scss'],
})
export class RecordPage implements OnInit {

  output: string = '';
  success: boolean = false;

  cowList?: any[];

  selectedCow?: string;

  recordForm: FormGroup = this.formBuilder.group<Record>({
    shift: 0,
    amount: 0,
    cowCaravana: undefined,
    date: undefined
  });

  constructor(private formBuilder: FormBuilder, private cowService: CowService, private recordService: RecordService) {}

  async ngOnInit() {
    this.getCows();
  }

  async getCows() {
    this.cowService.getCows().subscribe({
      next: (res) => {
        this.cowList = res;
      },
      error: (err) => {
        console.log(err);
      }
    });
  }

  selectCow(caravana: string) {
    this.selectedCow = caravana;
    this.recordForm.get('cowCaravana')?.setValue(caravana);
  }

  clearSelectedCow() {
    this.selectedCow = undefined;
    this.recordForm.get('cowCaravana')?.setValue(undefined);
  }

  registerRecord() {
    this.success = false;
    this.output = 'Seleccionar vaca primero';
    if (!this.selectedCow) return;
    this.output = '';
    this.recordService.registerRecord(this.recordForm.value).subscribe({next: (res) => {
      this.output = 'Registro creado correctamante';
      this.success = true;
    }, error: (err) => {
      console.log(err);
      this.output = err.error.message;
      this.success = false;
    }});
    this.recordForm.reset();
    this.recordForm.get('cowCaravana')?.setValue(this.selectedCow);
  }

}
