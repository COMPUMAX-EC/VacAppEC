import { ComponentFixture, TestBed } from '@angular/core/testing';
import { NewCowPage } from './new-cow.page';

describe('NewCowPage', () => {
  let component: NewCowPage;
  let fixture: ComponentFixture<NewCowPage>;

  beforeEach(async(() => {
    fixture = TestBed.createComponent(NewCowPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  }));

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
