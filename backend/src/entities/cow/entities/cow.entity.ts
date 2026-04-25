import { Record } from "src/entities/record/entities/record.entity";
import { Column, Entity, OneToMany, PrimaryColumn } from "typeorm";
import { CreateCowDto } from "../dto/create-cow.dto";

@Entity()
export class Cow {
    @PrimaryColumn()
    caravana: string;

    @OneToMany(() => Record, (record) => record.cow)
    records: Record[];

    constructor(dto: CreateCowDto) {     
        for(let key in dto) {
            this[key] = dto[key];
        }
    }
}
