import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class RecordService {

  backendUrl = 'https://tuganado-production.up.railway.app';

  constructor(public http: HttpClient) { }

  getAll() {
    return this.http.get(this.backendUrl + '/record');
  }

  registerRecord(body: any) {
    return this.http.post(this.backendUrl + '/record', body);
  }

  deleteRecord(recordId: number) {
    return this.http.delete(this.backendUrl + '/record/' + recordId);
  }

  downloadData() {
    return this.http.get(this.backendUrl + '/record/download',{ responseType: 'blob' as 'json'});
  }
}
