import { PartialType } from '@nestjs/mapped-types';
import { CreateCowDto } from './create-cow.dto';

export class UpdateCowDto extends PartialType(CreateCowDto) {}
