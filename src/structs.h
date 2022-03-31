#include "enums.h"

typedef struct {
    int skill;
    unsigned int value;
} ArmorSkill;


typedef struct {
    int pieces[5];
} ArmorSet;

typedef struct node{
    ArmorSet value;
    struct node * next;
    struct node * prev;
} ArmorSetNode;

typedef struct {
    unsigned int id;
    unsigned int type;
    unsigned int rarity;
    unsigned int defense;
    int fire_res;
    int ice_res;
    int thunder_res;
    int water_res;
    int dragon_res;
    unsigned int num_skills;
    ArmorSkill * skills;
} ArmorPiece;
