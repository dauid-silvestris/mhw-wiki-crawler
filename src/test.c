#include <stdio.h>
#include <stdlib.h>
#include "structs.h"


void printPiece(ArmorPiece * piece){
    printf("ID: %d\n", (*piece).id);
    printf("Type: %d\n", (*piece).type);
    printf("Rarity: %d\n", (*piece).rarity);
    printf("Defense: %d\n", (*piece).defense);
    printf("Fire Res: %d\n", (*piece).fire_res);
    printf("Ice Res: %d\n", (*piece).ice_res);
    printf("Thunder Res: %d\n", (*piece).thunder_res);
    printf("Water Res: %d\n", (*piece).water_res);
    printf("Dragon Res: %d\n", (*piece).dragon_res);
    printf("Numskills: %d\n", (*piece).num_skills);
    int i;
    for(i=0; i < (*piece).num_skills; i++){
        printf("Skill: %d\n", (*piece).skills[i].skill);
        printf("Value: %d\n", (*piece).skills[i].value);
    }
}

void loadPieces(char * filename, int * num, ArmorPiece ** bar){
    int i,j;
    FILE * fileptr;
    fileptr = fopen(filename, "r");
    
    int num_pieces;
    fread(&num_pieces, sizeof(int), 1, fileptr);
    *num = num_pieces;

    *bar = (ArmorPiece*)malloc(sizeof(ArmorPiece) * num_pieces);
    ArmorPiece * result = *bar;
    printf("Pointer: %p\n", result);

    // ArmorPiece result[num_pieces];

    for(i = 0; i< num_pieces; i++){
        fread(&result[i],sizeof(ArmorPiece) - 8 ,1,fileptr);
        result[i].skills = (ArmorSkill*)malloc( sizeof(ArmorSkill)*result[i].num_skills );

        for(j = 0; j < result[i].num_skills; j++){
            fread(&result[i].skills[i], sizeof(ArmorSkill), 1, fileptr );

            // printf("Skill: %d\n", (result[i].skills[i] ).skill);
        }
        printPiece(&result[i]);
    }

    fclose(fileptr);
};


int main(){
    int i,j;
    // FILE * fileptr;
    // fileptr = fopen("test.dat", "r");
    
    // int num_pieces;
    // fread(&num_pieces, sizeof(int), 1, fileptr);
    // ArmorPiece result[num_pieces];

    // for(i = 0; i< num_pieces; i++){
    //     fread(&result[i],sizeof(ArmorPiece) - 8 ,1,fileptr);
    //     result[i].skills = (ArmorSkill*)malloc( sizeof(ArmorSkill)*result[i].num_skills );

    //     for(j = 0; j < result[i].num_skills; j++){
    //         fread(&result[i].skills[i], sizeof(ArmorSkill), 1, fileptr );
    //     }
    // }

    ArmorPiece * result;
    int num_pieces;
    loadPieces("test.dat", &num_pieces, &result);
    printf("Pointer: %p\n", result);

    // printf("Num: %d\n", num_pieces);
    // for(i = 0; i< num_pieces; i++){
    //     ArmorPiece piece = result[i];
        
    //     printf("ID: %d\n", piece.id);
    //     printf("Type: %d\n", piece.type);
    //     printf("Rarity: %d\n", piece.rarity);
    //     printf("Defense: %d\n", piece.defense);
    //     printf("Fire Res: %d\n", piece.fire_res);
    //     printf("Ice Res: %d\n", piece.ice_res);
    //     printf("Thunder Res: %d\n", piece.thunder_res);
    //     printf("Water Res: %d\n", piece.water_res);
    //     printf("Dragon Res: %d\n", piece.dragon_res);
    //     printf("Numskills: %d\n", piece.num_skills);

    //     for(j = 0; j < piece.num_skills; j++){
    //         printf("Skill: %d\n", piece.skills[i].skill);
    //         printf("Value: %d\n", piece.skills[i].value);
    //     }
    //     printf("---------\n");
    // }

    // int num_piece_sets = 5
    // ArmorPiece * piece_sets[num_pieces] = [&HEADS, &CHESTS, &HANDS, &WAISTS, &LEGS]
    // int result[5];
    

    // ArmorSkill target1, target2;
    // target1.skill = HANDICRAFT;
    // target1.value = 3;
    // target2.skill = EARPLUGS;
    // target2.value = 3;


    // ArmorSkill target_levels[2] = {target1, target2};

    // ArmorSkill state[2];
    // state[0].skill = target_levels[0].skill;
    // state[0].value = 0;
    // state[2].skill = target_levels[1].skill;
    // state[1].value = 0;



    // ArmorSetNode root;
    // for(int i = 0; i < HEADGEARS.length; i++){
    //     for(int j = 0; j < 2; j++){
    //         ArmorPiece piece = HEADGEARS[i];
    //         ArmorSkill target_skill = target_levels[j].skill
    //         for(int k = 0; k < piece.num_skills; k++){
    //             piece_skill = piece.skills[k];
    //             if( piece_skill == target_skill){

    //             }
    //         }
    //     }
    // }
}