package Logics.Streamization.Taboo
{
   import Foundation.Streamization.TUnstreamizer;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Taboo.Data.TabooData;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerTaboo extends TUnstreamizer
   {
      
      public function TUnstreamizerTaboo()
      {
         super();
      }
      
      public function UnstreamizationGetHerosSkillCopy(param1:ByteArray) : TabooDataCell
      {
         var _loc2_:THero = null;
         var _loc3_:uint = 0;
         var _loc4_:TabooDataCell = null;
         _loc4_ = new TabooDataCell();
         _loc3_ = param1.readUnsignedInt();
         _loc4_.SetValueById(_loc3_);
         _loc2_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(param1.readUnsignedInt());
         _loc2_.AddTaboo(_loc4_);
         return _loc4_;
      }
      
      public function UnstreamizationGetHerosSkill(param1:ByteArray) : void
      {
         var _loc2_:THeros = null;
         var _loc3_:THero = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TabooDataCell = null;
         _loc4_ = param1.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new TabooDataCell();
            _loc6_.SetValueById(param1.readUnsignedInt());
            _loc6_.SkillCount = param1.readUnsignedInt();
            _loc3_ = SLogicsCore.Character.Heros.GetHeroByIdentifier(param1.readUnsignedInt());
            if(_loc3_)
            {
               _loc3_.AddTabooCopy(_loc6_);
            }
            _loc5_++;
         }
      }
      
      public function UnstreamizationPerformCopy(param1:ByteArray, param2:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc3_:TabooData = param2 as TabooData;
         _loc4_ = param1.readUnsignedInt();
         _loc3_.AddBackPackageById(_loc4_,param1.readUnsignedInt());
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TabooDataCell = null;
         var _loc4_:TabooData = param2 as TabooData;
         _loc5_ = param1.readShort();
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1.readUnsignedInt();
            _loc4_.AddBackPackageById(_loc7_,param1.readUnsignedInt());
            _loc6_++;
         }
      }
   }
}

