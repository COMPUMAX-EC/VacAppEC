import { Component, OnInit, ViewChild } from '@angular/core';
import { CowService } from '../services/cow.service';
import { RecordService } from '../services/record.service';
import { IonModal } from '@ionic/angular';
import { Filesystem, Directory, Encoding } from '@capacitor/filesystem';

@Component({
  selector: 'app-historical',
  templateUrl: './historical.page.html',
  styleUrls: ['./historical.page.scss'],
})
export class HistoricalPage implements OnInit {

  selectedCow?: string;
  records?: any[];

  cows?: any[];

  output?: string;
  success?: boolean;

  @ViewChild(IonModal) modal?: IonModal;
  recordId?: number;

  constructor(private cowService: CowService, private recordService: RecordService) { }

  ngOnInit() {
    this.getCows();
  }

  selectChange(event: any) {
    this.selectedCow = event.target.value;
    this.getRecords(event.target.value);
  }

  getRecords(caravana?: string, event?: any) {
    if (!caravana && event) return event.target.complete();
    if (!caravana) return;
    this.cowService.getCow(caravana).subscribe({
      next: (res) => {
        this.records = res.records.sort(function(a: any, b: any){
          return (new Date(b.date).getTime()) - (new Date(a.date).getTime());
        });
        if (event) event.target.complete();
      },
      error: (err) => {
        console.log(err);
      }
    })
  }

  deleteRecord() {

  }

  getCows() {
    this.cowService.getCows().subscribe({
      next: (res) => {
        this.cows = res;
      },
      error: (err) => {
        console.log(err);
      }
    })
  }

  downloadData() {
    this.recordService.downloadData().subscribe(async (res: any) => {
      let now: Date = new Date();
      let binaryData: BlobPart[] = [];
      binaryData.push(res);
        await Filesystem.writeFile({
          path: `tambo ${this.stringifyDate(now)}.xlsx`,
          data: new Blob(binaryData, {type: "application/ms-excel"}),
          directory: Directory.Documents,
          encoding: Encoding.UTF8,
        });
    })
  }

  stringifyDate(date: string | Date) {
    let d = new Date(date);
    let day = d.getDate();
    let month = d.getMonth()+1;
    let year = d.getFullYear();
    return `${day}/${month}/${year}`
  }

  cancel() {
    this.modal?.dismiss(null, 'cancel');
  }

  confirm() {
    this.modal?.dismiss(this.recordId, 'confirm');
  }

  onWillDismiss(event: Event) {
    const ev = event as CustomEvent<any>;
    if (ev.detail.role === 'confirm' && this.recordId) this.recordService.deleteRecord(this.recordId).subscribe(
      {
        next: (res) => {
          if (this.selectedCow) this.getRecords(this.selectedCow);
        },
        error: (err) => {
          this.success = false;
          this.output = err.message;
        },
      }
    );
  }

}
