package Logics.Kingwar
{
   public class TPVPKingPlayers
   {
      
      protected var FPVPKingPlayers:Vector.<TPVPKingPlayer>;
      
      public function TPVPKingPlayers()
      {
         super();
         this.FPVPKingPlayers = new Vector.<TPVPKingPlayer>();
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPVPKingPlayer = null;
         _loc1_ = int(this.FPVPKingPlayers.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.FPVPKingPlayers.pop();
            _loc2_++;
         }
         this.FPVPKingPlayers.length = 0;
      }
      
      public function Add(param1:TPVPKingPlayer) : void
      {
         this.FPVPKingPlayers.push(param1);
      }
      
      public function get PVPKingTop32() : Vector.<TPVPKingPlayer>
      {
         return this.FPVPKingPlayers;
      }
      
      public function get PVPKingTop16() : Vector.<TPVPKingPlayer>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPVPKingPlayer = null;
         var _loc4_:Vector.<TPVPKingPlayer> = null;
         var _loc5_:TPVPKingPlayer = null;
         _loc1_ = int(this.PVPKingTop32.length);
         _loc4_ = new Vector.<TPVPKingPlayer>();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.PVPKingTop32[_loc2_];
            if(Boolean(_loc3_) && _loc3_.Rank > 0)
            {
               _loc5_ = _loc3_.Clone();
               _loc5_.Pos /= 2;
               _loc4_.push(_loc5_);
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get PVPKingTop8() : Vector.<TPVPKingPlayer>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPVPKingPlayer = null;
         var _loc4_:Vector.<TPVPKingPlayer> = null;
         var _loc5_:TPVPKingPlayer = null;
         _loc1_ = int(this.PVPKingTop16.length);
         _loc4_ = new Vector.<TPVPKingPlayer>();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.PVPKingTop16[_loc2_];
            if(Boolean(_loc3_) && _loc3_.Rank > 1)
            {
               _loc5_ = _loc3_.Clone();
               _loc5_.Pos /= 2;
               _loc4_.push(_loc5_);
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get PVPKingTop4() : Vector.<TPVPKingPlayer>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPVPKingPlayer = null;
         var _loc4_:Vector.<TPVPKingPlayer> = null;
         var _loc5_:TPVPKingPlayer = null;
         _loc1_ = int(this.PVPKingTop8.length);
         _loc4_ = new Vector.<TPVPKingPlayer>();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.PVPKingTop8[_loc2_];
            if(Boolean(_loc3_) && _loc3_.Rank > 2)
            {
               _loc5_ = _loc3_.Clone();
               _loc5_.Pos /= 2;
               _loc4_.push(_loc5_);
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get PVPKingTop2() : Vector.<TPVPKingPlayer>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPVPKingPlayer = null;
         var _loc4_:Vector.<TPVPKingPlayer> = null;
         var _loc5_:TPVPKingPlayer = null;
         _loc1_ = int(this.PVPKingTop4.length);
         _loc4_ = new Vector.<TPVPKingPlayer>();
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.PVPKingTop4[_loc2_];
            if(Boolean(_loc3_) && _loc3_.Rank > 3)
            {
               _loc5_ = _loc3_.Clone();
               _loc5_.Pos /= 2;
               _loc4_.push(_loc5_);
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function get PVPKingTop1() : TPVPKingPlayer
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPVPKingPlayer = null;
         var _loc4_:TPVPKingPlayer = null;
         _loc1_ = int(this.PVPKingTop2.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.PVPKingTop2[_loc2_];
            if(Boolean(_loc3_) && _loc3_.Rank > 4)
            {
               _loc4_ = _loc3_.Clone();
               _loc4_.Pos /= 2;
               break;
            }
            _loc2_++;
         }
         return _loc4_;
      }
   }
}

