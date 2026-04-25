import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CowService } from './cow.service';
import { CreateCowDto } from './dto/create-cow.dto';
import { UpdateCowDto } from './dto/update-cow.dto';

@Controller('cow')
export class CowController {
  constructor(private readonly cowService: CowService) {}

  @Post()
  create(@Body() createCowDto: CreateCowDto) {
    return this.cowService.create(createCowDto);
  }

  @Get()
  findAll() {
    return this.cowService.findAll();
  }

  @Get(':caravana')
  findOne(@Param('caravana') caravana: string) {
    return this.cowService.findOne(caravana);
  }

  @Patch(':caravana')
  update(@Param('caravana') caravana: string, @Body() updateCowDto: UpdateCowDto) {
    return this.cowService.update(caravana, updateCowDto);
  }

  @Delete(':caravana')
  remove(@Param('caravana') caravana: string) {
    return this.cowService.remove(caravana);
  }
}
