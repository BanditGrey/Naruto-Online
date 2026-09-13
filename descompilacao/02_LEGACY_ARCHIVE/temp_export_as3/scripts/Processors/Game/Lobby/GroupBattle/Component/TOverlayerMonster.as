package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.Common.TCoordinate;
   import Foundation.UI.TUIComponent;
   import Logics.Campaign.TMonster;
   import Logics.Campaign.TMonsters;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import Resources.Constants.CONST_COMMON;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TOverlayerMonster extends TUIComponent
   {
      
      public static var STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static var STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      protected const CAPACITY_ITEMS:uint = 7;
      
      protected var FTF_GroupName:TextField;
      
      protected var FTF_GroupLevel:TextField;
      
      protected var FUIMonsterHeads:Vector.<TUIHeroHead>;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FResource:Sprite;
      
      protected var FContext:Object;
      
      public function TOverlayerMonster(param1:TUIComponent)
      {
         super(param1);
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.FUIMonsterHeads = new Vector.<TUIHeroHead>(this.CAPACITY_ITEMS);
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
      }
      
      protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         this.FResource.mouseEnabled = false;
         this.FResource.mouseChildren = false;
         this.addChild(this.FResource);
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIHeroHead(this);
            _loc3_.Resource = this.FResource["MC_Monster_" + _loc1_];
            _loc3_.Init();
            this.FUIMonsterHeads[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FTF_GroupName = this.FResource["TF_GroupName"];
         this.FTF_GroupLevel = this.FResource["TF_GroupLevel"];
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TMonsters = null;
         this.Reset();
         if(this.FContext == null)
         {
            return;
         }
         _loc1_ = this.FContext as TMonsters;
         this.FTF_GroupName.text = _loc1_.GetMonsterByIndex(0).TeamName;
         this.FTF_GroupLevel.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FGroupBattleData.RoomDetailInfo.GroupBattleLevel.RecommendLevel);
      }
      
      protected function UpdateUIPosition(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = this.FResource.width;
         _loc5_ = this.FResource.height;
         _loc2_ = param1.X + 50;
         if(_loc2_ + _loc4_ > STAGE_Width)
         {
            _loc2_ -= _loc4_ + 60;
         }
         else
         {
            _loc2_ -= 30;
         }
         _loc3_ = param1.Y;
         if(_loc3_ + _loc5_ + 30 > STAGE_Height)
         {
            _loc3_ = param1.Y - _loc5_;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = param1.Y;
            _loc3_ = param1.Y - (_loc3_ + _loc5_ + 30 - STAGE_Height);
         }
         this.X = _loc2_;
         this.Y = _loc3_;
      }
      
      protected function UpdateMonsterHead() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:TMonster = null;
         _loc2_ = this.CAPACITY_ITEMS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUIMonsterHeads[_loc1_];
            _loc4_ = this.CheckCorrectPosition(_loc1_);
            _loc3_.Context = _loc4_;
            _loc3_.UpdateUI();
            _loc1_++;
         }
      }
      
      protected function CheckCorrectPosition(param1:uint) : TMonster
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TMonsters = null;
         var _loc5_:TMonster = null;
         _loc4_ = this.FContext as TMonsters;
         if(_loc4_ == null)
         {
            return null;
         }
         _loc3_ = uint(_loc4_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetMonsterByIndex(_loc2_);
            if(param1 == _loc5_.MonsterPos)
            {
               return _loc5_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get Resource() : Sprite
      {
         return this.FResource;
      }
      
      public function set Resource(param1:Sprite) : void
      {
         this.FResource = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
         if(param1 != null)
         {
            this.UpdateUI();
         }
      }
      
      public function Perform_UIDispatch() : void
      {
         this.ResourcesPerform_UIDispatch();
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIHeroHead = null;
         this.FTF_GroupName.text = "";
         this.FTF_GroupLevel.text = "";
         _loc1_ = 0;
         while(_loc1_ < this.CAPACITY_ITEMS)
         {
            _loc2_ = this.FUIMonsterHeads[_loc1_];
            _loc2_.Context = null;
            _loc1_++;
         }
      }
      
      public function Show() : void
      {
         this.Visible = true;
      }
      
      public function Hide() : void
      {
         this.Visible = false;
         this.Reset();
      }
      
      public function Render(param1:TCoordinate) : void
      {
         this.UpdateUIPosition(param1);
      }
      
      public function Update() : void
      {
         this.UpdateMonsterHead();
      }
   }
}

