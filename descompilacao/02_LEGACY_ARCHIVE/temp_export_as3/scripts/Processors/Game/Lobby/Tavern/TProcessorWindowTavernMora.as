package Processors.Game.Lobby.Tavern
{
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Tavern.*;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowTavernMora extends TUIComponent
   {
      
      protected static const MoraType_Count:uint = 3;
      
      protected static const CONST_HEROLIST_MAX:uint = 3;
      
      protected static const CONST_MORACHOOSE_MAX:uint = 3;
      
      protected static const BTN_QUALITY_BULE:uint = 3;
      
      protected static const BTN_QUALITY_PURPLE:uint = 4;
      
      protected static const BTN_QUALITY_GOLD:uint = 5;
      
      protected static const BTN_QUALITY_ORANGE:uint = 6;
      
      protected static const COLOR_QUALITY_BULE:uint = 6094297;
      
      protected static const COLOR_QUALITY_PURPLE:uint = 14245117;
      
      protected static const COLOR_QUALITY_GOLD:uint = 16763904;
      
      protected static const COLOR_QUALITY_ORANGE:uint = 16724736;
      
      protected static const INDEX_Station_Front:int = 1;
      
      protected static const INDEX_Station_Middle:int = 2;
      
      protected static const INDEX_Station_After:int = 3;
      
      protected static const CONST_PlanishRate:uint = 20;
      
      protected static const Event_PlayTalk:String = "playTalk";
      
      protected static const Event_EndMovie:String = "endMovie";
      
      protected var FScene:MovieClip;
      
      protected var FHeadIcons:Vector.<Bitmap>;
      
      protected var FMyRecouse:Bitmap;
      
      protected var FNpcRecouse:Bitmap;
      
      protected var FMyRecouseId:uint;
      
      protected var FNpcRecouseId:uint;
      
      protected var FSelected:Boolean;
      
      protected var FSelectIndex:int;
      
      protected var FTavernWarriorVect:Vector.<TTavernWarrior>;
      
      protected var FRoleModelBins:TBins;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FTaverWarriorBins:TBins;
      
      protected var FMoraTimes:uint;
      
      protected var FTalkIndex:uint;
      
      protected var FPayWinCost:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FIsWin:Boolean;
      
      protected var FIsPlanish:Boolean;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FTurnBackHeroList:Function;
      
      protected var FEffectGenerateText:Function;
      
      public function TProcessorWindowTavernMora(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:uint = 0;
         var _loc4_:Bitmap = null;
         var _loc5_:TConfigValue = null;
         super(param1);
         this.FScene = param2;
         this.FSelected = false;
         this.FMoraTimes = 0;
         this.FMyRecouse = new Bitmap();
         this.FScene.mc_myRecouse.addChild(this.FMyRecouse);
         this.FNpcRecouse = new Bitmap();
         this.FScene.mc_npcRecouse.addChild(this.FNpcRecouse);
         this.FHeadIcons = new Vector.<Bitmap>(CONST_HEROLIST_MAX);
         _loc3_ = 0;
         while(_loc3_ < CONST_HEROLIST_MAX)
         {
            _loc4_ = new Bitmap();
            this.FScene["mc_general_" + _loc3_].mc_headIcon.addChild(_loc4_);
            this.FScene["mc_general_" + _loc3_].mc_recruited.visible = false;
            this.FHeadIcons[_loc3_] = _loc4_;
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < CONST_MORACHOOSE_MAX)
         {
            TGameUtil.setButtonMode(this.FScene["mc_mora_" + _loc3_],true);
            this.FScene["mc_mora_" + _loc3_].addEventListener(MouseEvent.CLICK,this.OnMoraClick);
            _loc3_++;
         }
         TGameUtil.setButtonMode(this.FScene.mc_moraWin,true);
         this.FScene.mc_moraWin.addEventListener(MouseEvent.CLICK,this.OnMoraWinClick);
         this.FTavernWarriorVect = new Vector.<TTavernWarrior>(CONST_HEROLIST_MAX);
         this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FTaverWarriorBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Tavern_Warrior);
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TAVERN_Match_Cheat) as TConfigValue;
         this.FPayWinCost = _loc5_.Value.value;
         this.FCharacter = SLogicsCore.Character;
         this.FMyRecouseId = this.FCharacter.MainHero.LargeID;
         this.FScene.mc_moraEffect.addEventListener(Event_PlayTalk,this.OnPlayTalk);
         this.FScene.mc_moraEffect.addEventListener(Event_EndMovie,this.OnEndMovie);
         this.FScene.mc_dialogue.visible = false;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this);
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowRecharge = new TUIWindowRecharge(this);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
      }
      
      protected function GetStandPositionWithProfession(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case CONST_CHARACTER.PROFESSION_Agility:
            case CONST_CHARACTER.PROFESSION_Strength:
               _loc2_ = uint(INDEX_Station_Middle);
               break;
            case CONST_CHARACTER.PROFESSION_Defending:
               _loc2_ = uint(INDEX_Station_Front);
               break;
            case CONST_CHARACTER.PROFESSION_Intellect:
               _loc2_ = uint(INDEX_Station_After);
         }
         return _loc2_;
      }
      
      protected function GetColorWithQuality(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         switch(param1)
         {
            case BTN_QUALITY_BULE:
               _loc2_ = COLOR_QUALITY_BULE;
               break;
            case BTN_QUALITY_PURPLE:
               _loc2_ = COLOR_QUALITY_PURPLE;
               break;
            case BTN_QUALITY_GOLD:
               _loc2_ = COLOR_QUALITY_GOLD;
               break;
            case BTN_QUALITY_ORANGE:
               _loc2_ = COLOR_QUALITY_ORANGE;
               break;
            default:
               _loc2_ = COLOR_QUALITY_BULE;
         }
         return _loc2_;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TTavernWarrior = null;
         var _loc3_:TBaseHero = null;
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_HEROLIST_MAX)
         {
            _loc4_ = this.FScene["mc_general_" + _loc1_];
            _loc2_ = this.FTavernWarriorVect[_loc1_];
            _loc6_ = this.GetColorWithQuality(_loc2_.Awardsouls.Type);
            _loc4_.mc_soul.gotoAndStop(_loc2_.Awardsouls.Type);
            _loc4_.tf_generalSoul.text = String(_loc2_.Awardsouls.Value);
            _loc4_.tf_generalSoul.textColor = _loc6_;
            _loc3_ = this.FBaseHeroBins.GetDatebaseByIdentifier(_loc2_.AwardId) as TBaseHero;
            _loc4_.tf_generalName.text = _loc3_.Name;
            _loc4_.tf_generalName.textColor = _loc6_;
            _loc5_ = this.GetStandPositionWithProfession(_loc3_.Profession);
            _loc4_.mc_militaryType.gotoAndStop(_loc5_);
            _loc4_.mc_lost.visible = Boolean(_loc1_ < this.FMoraTimes);
            _loc1_++;
         }
         this.FScene.mc_rounds.gotoAndStop(this.FMoraTimes + 1);
      }
      
      protected function OnOutMora() : void
      {
         if(this.FTurnBackHeroList != null)
         {
            this.FTurnBackHeroList();
         }
      }
      
      protected function EnableBtn(param1:Boolean) : void
      {
         this.FScene.mouseEnabled = param1;
         this.FScene.mouseChildren = param1;
      }
      
      protected function OnMoraClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FSelected)
         {
            return;
         }
         this.FSelectIndex = int(String(param1.currentTarget.name).slice(8)) + 1;
         if(Math.random() * 100 < CONST_PlanishRate)
         {
            this.SetPlanish();
            return;
         }
         this.FSelected = true;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TavernNormalMoraReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.EnableBtn(false);
      }
      
      protected function OnMoraWinClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FSelected)
         {
            return;
         }
         _loc2_ = STRING_TAVERN.SureCostWin;
         _loc2_ = _loc2_.split("%count%").join(this.FPayWinCost);
         if(this.FPayWinCost > this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         this.FUIWindowConfirmation.Text = _loc2_;
         this.FUIWindowConfirmation.OnOK = this.OnMoraWinSure;
         this.FUIWindowConfirmation.visible = true;
      }
      
      protected function OnMoraWinSure(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FPayWinCost)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         this.FSelected = true;
         this.FSelectIndex = Math.random() * MoraType_Count + 1;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TavernNormalMoraReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.EnableBtn(false);
      }
      
      protected function OnPlayTalk(param1:Event) : void
      {
         var _loc2_:TTavernWarrior = null;
         this.FScene.mc_moraEffect.mc_moraResult.visible = true;
         this.FScene.mc_moraEffect.mc_moraResult.movie_icon.gotoAndPlay(1);
         if(!this.FIsPlanish)
         {
            this.FScene.mc_dialogue.visible = true;
            _loc2_ = this.FTavernWarriorVect[this.FTalkIndex];
            if(!this.FIsWin)
            {
               this.FScene.mc_dialogue.tf_dialogueText.text = _loc2_.WinDialogue;
            }
            else
            {
               this.FScene.mc_dialogue.tf_dialogueText.text = _loc2_.LoseDialogue;
            }
            this.FTalkIndex++;
         }
      }
      
      protected function OnEndMovie(param1:Event) : void
      {
         var _loc2_:TTavernWarrior = null;
         var _loc3_:TRoleModel = null;
         this.FScene.mc_moraEffect.mc_moraResult.visible = false;
         this.FScene.mc_moraEffect.visible = false;
         _loc2_ = this.FTavernWarriorVect[this.FMoraTimes];
         _loc3_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc2_.AwardId) as TRoleModel;
         this.FNpcRecouseId = _loc3_.RoleStyle;
         this.FScene.mc_dialogue.visible = false;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.visible = param1;
      }
      
      override public function get Visible() : Boolean
      {
         if(this.FScene == null)
         {
            return false;
         }
         return this.FScene.visible;
      }
      
      public function set TurnBackHeroList(param1:Function) : void
      {
         this.FTurnBackHeroList = param1;
      }
      
      public function get TurnBackHeroList() : Function
      {
         return this.FTurnBackHeroList;
      }
      
      public function set EffectGenerateText(param1:Function) : void
      {
         this.FEffectGenerateText = param1;
      }
      
      public function get EffectGenerateText() : Function
      {
         return this.FEffectGenerateText;
      }
      
      public function SetMoraData(param1:TMoras) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TTavernWarrior = null;
         var _loc4_:TMora = null;
         var _loc5_:TRoleModel = null;
         this.FMoraTimes = 0;
         this.FTalkIndex = 0;
         this.FTavernWarriorVect.length = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.Count)
         {
            _loc4_ = param1.GetMoraByIndex(_loc2_);
            _loc3_ = this.FTaverWarriorBins.GetDatebaseByIdentifier(_loc4_.TavernHeroId) as TTavernWarrior;
            this.FTavernWarriorVect.push(_loc3_);
            if(_loc4_.IsMoraWin)
            {
               this.FMoraTimes++;
               this.FTalkIndex++;
            }
            _loc2_++;
         }
         _loc3_ = this.FTavernWarriorVect[this.FMoraTimes];
         _loc5_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc3_.AwardId) as TRoleModel;
         this.FNpcRecouseId = _loc5_.RoleStyle;
         this.EnableBtn(true);
         this.FScene.mc_moraEffect.visible = false;
         this.UpdataUI();
      }
      
      public function SetMoraResult(param1:uint, param2:Boolean) : void
      {
         this.FIsWin = param2;
         this.FIsPlanish = false;
         this.FScene.mc_moraEffect.visible = true;
         this.FScene.mc_moraEffect.gotoAndPlay(1);
         if(param2)
         {
            this.FScene.mc_moraEffect.mc_handDown.gotoAndStop(this.FSelectIndex);
            this.FScene.mc_moraEffect.mc_handUp.gotoAndStop(1 + (this.FSelectIndex + 1) % MoraType_Count);
            this.FScene.mc_moraEffect.mc_moraResult.gotoAndStop("Win");
         }
         else
         {
            this.FScene.mc_moraEffect.mc_handDown.gotoAndStop(this.FSelectIndex);
            this.FScene.mc_moraEffect.mc_handUp.gotoAndStop(1 + this.FSelectIndex % MoraType_Count);
            this.FScene.mc_moraEffect.mc_moraResult.gotoAndStop("Lose");
            this.FMoraTimes = CONST_HEROLIST_MAX;
         }
         this.FMoraTimes++;
         if(this.FMoraTimes >= CONST_HEROLIST_MAX)
         {
            this.FMoraTimes = 0;
            setTimeout(this.OnOutMora,3000);
         }
         else
         {
            this.FScene.mc_rounds.gotoAndStop(this.FMoraTimes);
         }
         this.UpdataUI();
         this.FSelected = false;
         this.EnableBtn(true);
      }
      
      public function SetPlanish() : void
      {
         this.FIsPlanish = true;
         this.FScene.mc_moraEffect.visible = true;
         this.FScene.mc_moraEffect.gotoAndPlay(1);
         this.FScene.mc_moraEffect.mc_handDown.gotoAndStop(this.FSelectIndex);
         this.FScene.mc_moraEffect.mc_handUp.gotoAndStop(this.FSelectIndex);
         this.FScene.mc_moraEffect.mc_moraResult.gotoAndStop("Planish");
      }
      
      public function UpdataTavernHeroHeadBitmap() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TRoleModel = null;
         var _loc3_:TTavernWarrior = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_HEROLIST_MAX)
         {
            _loc3_ = this.FTavernWarriorVect[_loc1_];
            _loc2_ = this.FRoleModelBins.GetDatebaseByIdentifier(_loc3_.AwardId) as TRoleModel;
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeadIcons[_loc1_],CONST_MODULES.MODULE_Tavern,_loc2_.RoleHead);
            _loc1_++;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FMyRecouse,CONST_MODULES.MODULE_Tavern,this.FMyRecouseId);
         TGameUtil.ShowImageByID(TGameUtil.Type_LargeIcon,this.FNpcRecouse,CONST_MODULES.MODULE_Tavern,this.FNpcRecouseId);
      }
   }
}

