import { ConflictException, Injectable, NotFoundException } from '@nestjs/common';
import { CreateCowDto } from './dto/create-cow.dto';
import { UpdateCowDto } from './dto/update-cow.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Cow } from './entities/cow.entity';
import { Repository } from 'typeorm';

@Injectable()
export class CowService {
  constructor (@InjectRepository(Cow)
  private readonly cowRepository: Repository<Cow>){}
  async create(createCowDto: CreateCowDto) {
    if (await this.cowRepository.findOne({where: {caravana: createCowDto.caravana}})) throw new ConflictException('Ya existe una vaca con dicha caravana');
    let cow: Cow = new Cow(createCowDto);
    return this.cowRepository.insert(cow);
  }

  findAll() {
    return this.cowRepository.find();
  }

  async findOne(caravana: string) {
    let cow: Cow = await this.cowRepository.findOne({where: {caravana: caravana}, relations: {records: true}});
    if (!cow) throw new NotFoundException("No se encontró una vaca con dicha caravana");
    return cow;
  }

  update(caravana: string, updateCowDto: UpdateCowDto) {
    return this.cowRepository.update({caravana: caravana}, updateCowDto);
  }

  async remove(caravana: string) {
    if (!await this.cowRepository.findOne({ where: { caravana: caravana } })) throw new NotFoundException("La vaca no existe");
    return this.cowRepository.delete({caravana: caravana});
  }
}
