package Processors.Game.Lobby.Magic.Window
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import Logics.DatebaseVO.VO.TMewBattle;
   import Logics.Magic.TMagic;
   import Logics.Magic.TMagicData;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Magic.Components.TUILevel;
   import Resources.Constants.CONST_MAGIC;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_MAGIC;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowLevels extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_Levels:uint = 3;
      
      protected var FMC_Reward:MovieClip;
      
      protected var FTF_Title:TextField;
      
      protected var FUILevels:Vector.<TUILevel>;
      
      protected var FMagicData:TMagicData;
      
      protected var FLevelIndex:int;
      
      protected var FMewBattle:TMewBattle;
      
      protected var FCurMewBattle:TMewBattle;
      
      protected var FAwards:Vector.<TFixedAward>;
      
      protected var FHint:THint;
      
      protected var FChallengeOnClick:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      public function TProcessorWindowLevels(param1:TUIComponent)
      {
         super(param1);
         this.FUILevels = new Vector.<TUILevel>(this.CAPACITY_Levels);
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MAGIC.RESOURCESID_Swf_Magic);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUILevel = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_MAGIC.RESOURCE_ClassName_MC_Levels) as Sprite;
         TGameUtil.AddWindowMask(this);
         UIDispatch();
         _loc2_ = this.CAPACITY_Levels;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUILevel(this);
            _loc3_.Resource = FMainUI["MC_Enemy_" + _loc1_];
            _loc3_.Tag = _loc1_;
            _loc3_.ChallengeOnClick = this.ProcessorChallengeOnClick;
            _loc3_.OnOut = this.ProcessorUILevelOnOut;
            _loc3_.OnOver = this.ProcessorUILevelOnOver;
            _loc3_.Init();
            this.FUILevels[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FMC_Reward = FMainUI[CONST_MAGIC.RESOURCE_Link_MC_Reward];
         this.FTF_Title = FMainUI[CONST_MAGIC.RESOURCE_Link_TF_Title];
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
         this.FMC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRewardOnOver,false,0,true);
         this.FMC_Reward.addEventListener(MouseEvent.MOUSE_OUT,this.MCRewardOnOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateOtherInfo() : void
      {
         var _loc1_:uint = 0;
         this.FTF_Title.text = STRING_MAGIC.STRING_Levels[this.FLevelIndex];
         _loc1_ = 100003 + this.FLevelIndex * 3;
         this.FCurMewBattle = this.FMagicData.MagicLevels.GetMagicLevelByIdentifier(_loc1_);
         if(this.FMagicData.StageID >= _loc1_)
         {
            this.FMC_Reward.gotoAndStop(2);
         }
         this.FAwards = this.FCurMewBattle.Awardexs;
      }
      
      protected function UpdateLevels() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUILevel = null;
         var _loc4_:TMewBattle = null;
         var _loc5_:int = 0;
         _loc2_ = this.FMagicData.MagicLevels.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = this.FMagicData.MagicLevels.GetMewBattleByIndex(_loc1_);
            if(_loc4_.Location == this.FLevelIndex)
            {
               _loc5_ = (_loc4_.Identifier - 1) % 100 % 3;
               _loc3_ = this.FUILevels[_loc5_];
               _loc3_.Context = _loc4_;
               _loc3_.Update(this.FMagicData);
            }
            _loc1_++;
         }
      }
      
      override protected function ProcessorWindowClose() : void
      {
         super.ProcessorWindowClose();
      }
      
      protected function ProcessorChallengeOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TMewBattle = null;
         _loc3_ = param2 as TMewBattle;
         if(_loc3_ == null)
         {
            return;
         }
         if(this.FMagicData.StageID != 0)
         {
            if(this.FMagicData.StageID != _loc3_.Identifier - 1)
            {
               return;
            }
         }
         else if(_loc3_.Identifier != 100001)
         {
            return;
         }
         if(this.FChallengeOnClick != null)
         {
            this.FChallengeOnClick(this,param2);
         }
      }
      
      protected function ProcessorUILevelOnOut(param1:Object) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      protected function ProcessorUILevelOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TMewBattle = null;
         var _loc4_:uint = 0;
         var _loc5_:TMagic = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:TFixedAward = null;
         var _loc13_:int = 0;
         if(param2 == null)
         {
            return;
         }
         _loc3_ = param2 as TMewBattle;
         _loc4_ = this.FMagicData.StageID;
         if(_loc4_ >= _loc3_.Identifier)
         {
            return;
         }
         if(_loc4_ == 0 && _loc3_.Identifier == 100001 || _loc3_.Identifier == 100004 && _loc4_ + 1 == 100004 || _loc3_.Identifier == 100007 && _loc4_ + 1 == 100007 || _loc3_.Identifier == 100022 && _loc4_ + 1 == 100022)
         {
            _loc13_ = _loc3_.Identifier % 100 / 3;
            if(_loc13_ > 2)
            {
               _loc13_ = 3;
            }
            _loc5_ = this.FMagicData.Magics.GetMagicByIndex(_loc13_);
            _loc6_ = TUtilityString.Format(STRING_MAGIC.FORMAt_WinGetMagic,_loc5_.MagicName);
         }
         else
         {
            _loc8_ = _loc3_.Awards.length;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               _loc6_ = "";
               _loc12_ = _loc3_.Awards[_loc7_];
               _loc9_ = _loc12_.Type;
               _loc10_ = _loc12_.Code;
               _loc11_ = _loc12_.Amount;
               _loc6_ = TUtilityString.Format(STRING_MAGIC.FORMAt_WinGet,STRING_COMMON.GetItemNameByType(_loc9_,_loc10_),_loc11_);
               _loc6_ = _loc6_ + "\n";
               _loc7_++;
            }
         }
         this.FHint.Caption = _loc6_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:TFixedAward = null;
         _loc4_ = this.FAwards.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = "";
            _loc8_ = this.FAwards[_loc3_];
            _loc5_ = _loc8_.Type;
            _loc6_ = _loc8_.Code;
            _loc7_ = _loc8_.Amount;
            _loc2_ = TUtilityString.Format(STRING_MAGIC.FORMAt_PassAllGet,STRING_COMMON.GetItemNameByType(_loc5_,_loc6_),_loc7_);
            _loc2_ += "\n";
            _loc3_++;
         }
         this.FHint.Caption = _loc2_;
         if(this.FUIHintOnOver != null)
         {
            this.FUIHintOnOver(this,this.FHint);
         }
      }
      
      protected function MCRewardOnOut(param1:MouseEvent) : void
      {
         if(this.FUIHintOnOut != null)
         {
            this.FUIHintOnOut(this);
         }
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         super.ButtonCloseOnClick(param1);
         this.FMC_Reward.gotoAndStop(1);
      }
      
      public function get ChallengeOnClick() : Function
      {
         return this.FChallengeOnClick;
      }
      
      public function set ChallengeOnClick(param1:Function) : void
      {
         this.FChallengeOnClick = param1;
      }
      
      public function get UIHintOnOver() : Function
      {
         return this.FUIHintOnOver;
      }
      
      public function set UIHintOnOver(param1:Function) : void
      {
         this.FUIHintOnOver = param1;
      }
      
      public function get UIHintOnOut() : Function
      {
         return this.FUIHintOnOut;
      }
      
      public function set UIHintOnOut(param1:Function) : void
      {
         this.FUIHintOnOut = param1;
      }
      
      public function Update(param1:TMagicData, param2:int) : void
      {
         this.FMagicData = param1;
         this.FLevelIndex = param2;
         this.FMewBattle = this.FMagicData.MagicLevels.GetMagicLevelByIdentifier(this.FMagicData.StageID);
         this.UpdateLevels();
         this.UpdateOtherInfo();
      }
   }
}

