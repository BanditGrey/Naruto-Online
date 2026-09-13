package Logics.Battle
{
   public class TBattleConfig
   {
      
      private static const FORMATION_X1:Array = [[450,320,190],[495,365,235],[405,275,145],[540,410,280],[360,230,100]];
      
      private static const FORMATION_X2:Array = [[800,930,1060],[755,885,1015],[845,975,1105],[710,840,970],[890,1020,1150]];
      
      private static const FORMATION_Y:Array = [485,435,535,385,585];
      
      protected var FORMATION_POS_0_1:Vector.<int>;
      
      protected var FORMATION_POS_0_2:Vector.<int>;
      
      protected var FORMATION_POS_0_3:Vector.<int>;
      
      protected var FORMATION_POS_0_4:Vector.<int>;
      
      protected var FORMATION_POS_0_5:Vector.<int>;
      
      protected var FORMATION_POS_0_6:Vector.<int>;
      
      protected var FORMATION_POS_0_7:Vector.<int>;
      
      protected var FORMATION_POS_0_8:Vector.<int>;
      
      protected var FORMATION_POS_0_9:Vector.<int>;
      
      protected var FORMATION_POS_0_10:Vector.<int>;
      
      protected var FORMATION_POS_0_11:Vector.<int>;
      
      protected var FORMATION_POS_0_12:Vector.<int>;
      
      protected var FORMATION_POS_0_13:Vector.<int>;
      
      protected var FORMATION_POS_0_14:Vector.<int>;
      
      protected var FORMATION_POS_0_15:Vector.<int>;
      
      protected var FORMATION_POS_1_1:Vector.<int>;
      
      protected var FORMATION_POS_1_2:Vector.<int>;
      
      protected var FORMATION_POS_1_3:Vector.<int>;
      
      protected var FORMATION_POS_1_4:Vector.<int>;
      
      protected var FORMATION_POS_1_5:Vector.<int>;
      
      protected var FORMATION_POS_1_6:Vector.<int>;
      
      protected var FORMATION_POS_1_7:Vector.<int>;
      
      protected var FORMATION_POS_1_8:Vector.<int>;
      
      protected var FORMATION_POS_1_9:Vector.<int>;
      
      protected var FORMATION_POS_1_10:Vector.<int>;
      
      protected var FORMATION_POS_1_11:Vector.<int>;
      
      protected var FORMATION_POS_1_12:Vector.<int>;
      
      protected var FORMATION_POS_1_13:Vector.<int>;
      
      protected var FORMATION_POS_1_14:Vector.<int>;
      
      protected var FORMATION_POS_1_15:Vector.<int>;
      
      public const SHOWIDX:Vector.<int> = Vector.<int>([4,9,14,2,7,12,1,6,11,3,8,13,5,10,15]);
      
      public const Type_PostionX:int = 0;
      
      public const Type_PostionY:int = 1;
      
      public function TBattleConfig()
      {
         super();
         this.FORMATION_POS_0_1 = Vector.<int>([FORMATION_X1[0][0],FORMATION_Y[0]]);
         this.FORMATION_POS_0_2 = Vector.<int>([FORMATION_X1[1][0],FORMATION_Y[1]]);
         this.FORMATION_POS_0_3 = Vector.<int>([FORMATION_X1[2][0],FORMATION_Y[2]]);
         this.FORMATION_POS_0_4 = Vector.<int>([FORMATION_X1[3][0],FORMATION_Y[3]]);
         this.FORMATION_POS_0_5 = Vector.<int>([FORMATION_X1[4][0],FORMATION_Y[4]]);
         this.FORMATION_POS_0_6 = Vector.<int>([FORMATION_X1[0][1],FORMATION_Y[0]]);
         this.FORMATION_POS_0_7 = Vector.<int>([FORMATION_X1[1][1],FORMATION_Y[1]]);
         this.FORMATION_POS_0_8 = Vector.<int>([FORMATION_X1[2][1],FORMATION_Y[2]]);
         this.FORMATION_POS_0_9 = Vector.<int>([FORMATION_X1[3][1],FORMATION_Y[3]]);
         this.FORMATION_POS_0_10 = Vector.<int>([FORMATION_X1[4][1],FORMATION_Y[4]]);
         this.FORMATION_POS_0_11 = Vector.<int>([FORMATION_X1[0][2],FORMATION_Y[0]]);
         this.FORMATION_POS_0_12 = Vector.<int>([FORMATION_X1[1][2],FORMATION_Y[1]]);
         this.FORMATION_POS_0_13 = Vector.<int>([FORMATION_X1[2][2],FORMATION_Y[2]]);
         this.FORMATION_POS_0_14 = Vector.<int>([FORMATION_X1[3][2],FORMATION_Y[3]]);
         this.FORMATION_POS_0_15 = Vector.<int>([FORMATION_X1[4][2],FORMATION_Y[4]]);
         this.FORMATION_POS_1_1 = Vector.<int>([FORMATION_X2[0][0],FORMATION_Y[0]]);
         this.FORMATION_POS_1_2 = Vector.<int>([FORMATION_X2[1][0],FORMATION_Y[1]]);
         this.FORMATION_POS_1_3 = Vector.<int>([FORMATION_X2[2][0],FORMATION_Y[2]]);
         this.FORMATION_POS_1_4 = Vector.<int>([FORMATION_X2[3][0],FORMATION_Y[3]]);
         this.FORMATION_POS_1_5 = Vector.<int>([FORMATION_X2[4][0],FORMATION_Y[4]]);
         this.FORMATION_POS_1_6 = Vector.<int>([FORMATION_X2[0][1],FORMATION_Y[0]]);
         this.FORMATION_POS_1_7 = Vector.<int>([FORMATION_X2[1][1],FORMATION_Y[1]]);
         this.FORMATION_POS_1_8 = Vector.<int>([FORMATION_X2[2][1],FORMATION_Y[2]]);
         this.FORMATION_POS_1_9 = Vector.<int>([FORMATION_X2[3][1],FORMATION_Y[3]]);
         this.FORMATION_POS_1_10 = Vector.<int>([FORMATION_X2[4][1],FORMATION_Y[4]]);
         this.FORMATION_POS_1_11 = Vector.<int>([FORMATION_X2[0][2],FORMATION_Y[0]]);
         this.FORMATION_POS_1_12 = Vector.<int>([FORMATION_X2[1][2],FORMATION_Y[1]]);
         this.FORMATION_POS_1_13 = Vector.<int>([FORMATION_X2[2][2],FORMATION_Y[2]]);
         this.FORMATION_POS_1_14 = Vector.<int>([FORMATION_X2[3][2],FORMATION_Y[3]]);
         this.FORMATION_POS_1_15 = Vector.<int>([FORMATION_X2[4][2],FORMATION_Y[4]]);
      }
      
      public function GetPostionByCamyPos(param1:int, param2:int, param3:int) : Number
      {
         if(param1 != 0 && param1 != 1)
         {
            return 0;
         }
         if(param2 < 1 && param2 > 15)
         {
            return 0;
         }
         if(param3 != 0 && param3 != 1)
         {
            return 0;
         }
         return this["FORMATION_POS_" + param1 + "_" + param2][param3];
      }
   }
}

