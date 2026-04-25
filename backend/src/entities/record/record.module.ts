import { Module } from '@nestjs/common';
import { RecordService } from './record.service';
import { RecordController } from './record.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Record } from './entities/record.entity';
import { Cow } from '../cow/entities/cow.entity';
import { ExcelService } from 'src/services/excel/excel.service';

@Module({
  imports: [TypeOrmModule.forFeature([Record, Cow])],
  controllers: [RecordController],
  providers: [RecordService, ExcelService]
})
export class RecordModule {}
