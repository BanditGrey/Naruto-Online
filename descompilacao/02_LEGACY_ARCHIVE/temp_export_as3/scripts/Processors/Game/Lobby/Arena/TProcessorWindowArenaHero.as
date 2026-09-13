package Processors.Game.Lobby.Arena
{
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Arena.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.Windows.Information.TUIWindowBattleSkip;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowArenaHero extends TUIComponent
   {
      
      protected static const HERO_Count:uint = 10;
      
      protected var FScene:MovieClip;
      
      protected var FArenaHeros:TArenaHeros;
      
      protected var FMySelfIdentifier0:uint;
      
      protected var FMySelfIdentifier1:uint;
      
      protected var FMySelfIndex:int;
      
      protected var FFightIndex:int;
      
      protected var FUIWindowBattleSkip:TUIWindowBattleSkip;
      
      protected var FCheckCanFight:Function;
      
      protected var FTutorialNextStep:Function;
      
      public function TProcessorWindowArenaHero(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:uint = 0;
         var _loc4_:Bitmap = null;
         super(param1);
         this.FScene = param2;
         _loc3_ = 0;
         while(_loc3_ < HERO_Count)
         {
            this.FScene["mc_hero_" + _loc3_].addEventListener(MouseEvent.CLICK,this.OnFightArena);
            this.FScene["mc_hero_" + _loc3_].addEventListener(MouseEvent.ROLL_OVER,this.OnHeroRoll);
            this.FScene["mc_hero_" + _loc3_].addEventListener(MouseEvent.ROLL_OUT,this.OnHeroRoll);
            this.FScene["mc_hero_" + _loc3_].buttonMode = true;
            _loc4_ = new Bitmap();
            this.FScene["mc_hero_" + _loc3_].image["bitmap"] = _loc4_;
            this.FScene["mc_hero_" + _loc3_].image.addChild(_loc4_);
            this.FScene["mc_hero_" + _loc3_].tf_light.visible = false;
            this.FScene["mc_hero_" + _loc3_].tf_light.mouseEnabled = false;
            _loc3_++;
         }
         this.FScene.mc_rank_1.mouseEnabled = false;
         this.FScene.mc_rank_2.mouseEnabled = false;
         this.FScene.mc_rank_3.mouseEnabled = false;
         this.FScene.mc_select.visible = false;
         this.FScene.mc_select.mouseEnabled = false;
         this.FMySelfIndex = -1;
         this.FUIWindowBattleSkip = new TUIWindowBattleSkip(this.Parent);
         this.FUIWindowBattleSkip.Perform_UIDispatch();
         this.FUIWindowBattleSkip.OnOK = this.OnConfirmationOk;
         this.FUIWindowBattleSkip.OnCancel = this.OnWindowCancel;
      }
      
      protected function SetHeroData(param1:TArenaHero, param2:MovieClip) : void
      {
         var _loc3_:MovieClip = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         param2.tf_Ranking.text = param1.Ranking.toString();
         param2.tf_name.text = param1.PlayerNick;
         param2.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.PlayerLevel);
         param2.tf_Ranking.mouseEnabled = false;
         param2.tf_name.mouseEnabled = false;
         param2.tf_level.mouseEnabled = false;
         if(param1.Ranking <= 3)
         {
            _loc3_ = this.FScene["mc_rank_" + param1.Ranking];
            _loc3_.visible = true;
            --param2.x;
            _loc3_.y = param2.y - 5;
         }
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TArenaHero = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         this.FScene.mc_rank_1.visible = false;
         this.FScene.mc_rank_2.visible = false;
         this.FScene.mc_rank_3.visible = false;
         _loc1_ = 0;
         while(_loc1_ < HERO_Count)
         {
            if(_loc1_ < this.FArenaHeros.Count)
            {
               _loc2_ = this.FArenaHeros.GetHeroByIndex(_loc1_);
               _loc3_ = _loc2_.Identifier0;
               _loc4_ = _loc2_.Identifier1;
               if(_loc3_ == this.FMySelfIdentifier0 && _loc4_ == this.FMySelfIdentifier1)
               {
                  this.FMySelfIndex = _loc1_;
                  this.FScene["mc_bg_" + _loc1_].gotoAndStop(3);
               }
               else
               {
                  this.FScene["mc_bg_" + _loc1_].gotoAndStop(1);
               }
               this.FScene["mc_hero_" + _loc1_].visible = true;
               this.FScene["mc_bg_" + _loc1_].visible = true;
               this.SetHeroData(this.FArenaHeros.GetHeroByIndex(_loc1_),this.FScene["mc_hero_" + _loc1_]);
            }
            else
            {
               this.FScene["mc_hero_" + _loc1_].visible = false;
               this.FScene["mc_bg_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function StartFightReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:TArenaHero = null;
         if(this.FTutorialNextStep != null)
         {
            this.FTutorialNextStep(1500);
         }
         _loc3_ = this.FArenaHeros.GetHeroByIndex(this.FFightIndex);
         if(_loc3_.Identifier0 == this.FMySelfIdentifier0 && _loc3_.Identifier1 == this.FMySelfIdentifier1)
         {
            return;
         }
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_Fight_Req);
         _loc2_ = _loc1_.Data;
         _loc2_.writeInt(_loc3_.Identifier0);
         _loc2_.writeInt(_loc3_.Identifier1);
         _loc2_.writeByte(this.FFightIndex);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function OnFightArena(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         this.FFightIndex = int(String(param1.currentTarget.name).slice(8));
         if(this.FCheckCanFight != null)
         {
            if(!this.FCheckCanFight())
            {
               return;
            }
         }
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.StartFightReq();
         }
      }
      
      protected function OnHeroRoll(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TArenaHero = null;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(8)));
         if(_loc2_ == this.FMySelfIndex)
         {
            return;
         }
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.FScene["mc_bg_" + _loc2_].gotoAndStop(2);
            this.FScene.mc_select.visible = true;
            this.FScene.mc_select.x = this.FScene["mc_hero_" + _loc2_].x;
            this.FScene.mc_select.y = this.FScene["mc_hero_" + _loc2_].y;
            this.FScene["mc_hero_" + _loc2_].tf_light.visible = true;
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            this.FScene["mc_bg_" + _loc2_].gotoAndStop(1);
            this.FScene.mc_select.visible = false;
            this.FScene["mc_hero_" + _loc2_].tf_light.visible = false;
         }
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(true,CONST_BATTLE.BattleType_Arena);
         this.FUIWindowBattleSkip.IsClickSkip = true;
         this.StartFightReq();
      }
      
      protected function OnWindowCancel(param1:Object) : void
      {
         this.FUIWindowBattleSkip.SetBattleSkipStatus(false,CONST_BATTLE.BattleType_Arena);
         this.FUIWindowBattleSkip.IsClickSkip = false;
         this.StartFightReq();
      }
      
      public function get OnCheckCanFight() : Function
      {
         return this.FCheckCanFight;
      }
      
      public function set OnCheckCanFight(param1:Function) : void
      {
         this.FCheckCanFight = param1;
      }
      
      public function get TutorialNextStep() : Function
      {
         return this.FTutorialNextStep;
      }
      
      public function set TutorialNextStep(param1:Function) : void
      {
         this.FTutorialNextStep = param1;
      }
      
      public function UpdataBitmap() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TRoleModel = null;
         if(this.FArenaHeros == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < HERO_Count)
         {
            if(_loc1_ >= this.FArenaHeros.Count)
            {
               break;
            }
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,this.FArenaHeros.GetHeroByIndex(_loc1_).HeroId) as TRoleModel;
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FScene["mc_hero_" + _loc1_].image["bitmap"],CONST_MODULES.MODULE_Arena,_loc2_.RoleHead);
            _loc1_++;
         }
      }
      
      public function SetArenaHeros(param1:TArenaHeros) : void
      {
         this.FArenaHeros = param1;
         this.FMySelfIdentifier0 = SLogicsCore.Character.Identifier0;
         this.FMySelfIdentifier1 = SLogicsCore.Character.Identifier1;
         this.UpdataUI();
      }
      
      public function StartFight() : void
      {
         if(!this.FUIWindowBattleSkip.IsSelected)
         {
            this.FUIWindowBattleSkip.Visible = true;
         }
         else
         {
            this.StartFightReq();
         }
      }
   }
}

