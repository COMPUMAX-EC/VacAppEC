import { Controller, Get, Post, Body, Patch, Param, Delete, Header, Res } from '@nestjs/common';
import { RecordService } from './record.service';
import { CreateRecordDto } from './dto/create-record.dto';
import { UpdateRecordDto } from './dto/update-record.dto';
import { ExcelService } from 'src/services/excel/excel.service';
import { Response } from 'express';
 
@Controller('record')
export class RecordController {
  constructor(private readonly recordService: RecordService, private readonly excelService: ExcelService) {}

  @Post()
  create(@Body() createRecordDto: CreateRecordDto) {
    return this.recordService.create(createRecordDto);
  }

  @Get()
  findAll() {
    return this.recordService.findAll();
  }

  @Get('download')
  @Header('Content-Type', 'text/xlsx')
  async downloadHistorical(@Res() res: Response) {
    let result = await this.excelService.downloadHistorical();
    res.download(`${result}`);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.recordService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateRecordDto: UpdateRecordDto) {
    return this.recordService.update(+id, updateRecordDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.recordService.remove(+id);
  }
}
