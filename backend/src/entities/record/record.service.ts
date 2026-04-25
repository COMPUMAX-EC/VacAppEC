import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateRecordDto } from './dto/create-record.dto';
import { UpdateRecordDto } from './dto/update-record.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Record } from './entities/record.entity';
import { Repository } from 'typeorm';
import { Cow } from '../cow/entities/cow.entity';

@Injectable()
export class RecordService {
  constructor(@InjectRepository(Record)
  private readonly recordRepository: Repository<Record>,
  @InjectRepository(Cow)
  private readonly cowRepository: Repository<Cow>) {}

  async create(createRecordDto: CreateRecordDto) {
    let cow: Cow = await this.cowRepository.findOne({where: {caravana: createRecordDto.cowCaravana}})
    if (!cow) throw new NotFoundException("No se encontró la vaca");
    let record: Record = new Record(createRecordDto, cow);
    return this.recordRepository.insert(record);
  }

  findAll() {
    return this.recordRepository.find({relations: {cow: true}});
  }

  findOne(id: number) {
    return this.recordRepository.findOne({where: {id: id}});
  }

  update(id: number, updateRecordDto: UpdateRecordDto) {
    return this.recordRepository.update({id: id}, updateRecordDto);
  }

  remove(id: number) {
    return this.recordRepository.delete({id: id});
  }
}
