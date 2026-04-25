import { Module } from '@nestjs/common';
import { CowService } from './cow.service';
import { CowController } from './cow.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Cow } from './entities/cow.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Cow])],
  controllers: [CowController],
  providers: [CowService]
})
export class CowModule {}
