import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Workbook } from 'exceljs';
import { Record } from 'src/entities/record/entities/record.entity';
import { Repository } from 'typeorm';
import * as tmp from 'tmp';

@Injectable()
export class ExcelService {

    constructor(@InjectRepository(Record) private readonly recordRepository: Repository<Record>) {}

    async downloadHistorical() {
        let data: Record[] = await this.recordRepository.find();
        let rows = [];
        data.forEach(row => {
            rows.push(Object.values(row))
        })
        let book = new Workbook();
        let sheet = book.addWorksheet("Datos historicos");
        
        sheet.addRows(rows);
        let File = await new Promise((resolve, reject) => {
            tmp.file({ discardDescriptor: true, prefix: 'excel', postfix: '.xlsx', mode: parseInt('0600', 8) }, async (err, file) => {
                if (err) throw new BadRequestException("Error al crear el archivo temporal");
                book.xlsx.writeFile(file).then(_ => {
                    resolve(file);
                }).catch(err => {
                    throw new BadRequestException("Error al escribir el archivo temporal Excel")
                })
            })
        });
        return File;
    }
}
