package Logics.Characters
{
   import Logics.Characters.MoveRole.TRoleNpc;
   
   public class TNPCs
   {
      
      protected var FGameNPCs:Vector.<TGameNpc>;
      
      protected var FCityNPCs:Vector.<TGameNpc>;
      
      protected var FRoleNpc:Vector.<TRoleNpc>;
      
      public function TNPCs()
      {
         super();
         this.FGameNPCs = new Vector.<TGameNpc>();
         this.FCityNPCs = new Vector.<TGameNpc>();
         this.FRoleNpc = new Vector.<TRoleNpc>();
      }
      
      public function get GameNPC() : Vector.<TGameNpc>
      {
         return this.FGameNPCs;
      }
      
      public function Count() : int
      {
         return this.FRoleNpc.length;
      }
      
      public function Add(param1:TRoleNpc) : void
      {
         this.FRoleNpc.push(param1);
      }
      
      public function GetRoleNpcByIndex(param1:int) : TRoleNpc
      {
         return this.FRoleNpc[param1];
      }
      
      public function GetNPCByID(param1:int) : TGameNpc
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(this.FGameNPCs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FGameNPCs[_loc2_].ID == param1)
            {
               return this.FGameNPCs[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetCityNPCsByID(param1:int) : Vector.<TGameNpc>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.ClearCityVector(this.FCityNPCs);
         _loc3_ = int(this.FGameNPCs.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FGameNPCs[_loc2_].Cityid == param1)
            {
               this.FCityNPCs.push(this.FGameNPCs[_loc2_]);
            }
            _loc2_++;
         }
         return this.FCityNPCs;
      }
      
      protected function ClearCityVector(param1:Vector.<TGameNpc>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            param1[_loc2_] = null;
            _loc2_++;
         }
         param1.length = 0;
      }
   }
}

