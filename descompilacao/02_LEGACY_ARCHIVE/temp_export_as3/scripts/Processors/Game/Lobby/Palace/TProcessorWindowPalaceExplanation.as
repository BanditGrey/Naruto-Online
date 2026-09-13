package Processors.Game.Lobby.Palace
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.CrossServerWar.TEliteRecord;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TGSPVP_Reward;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Palace.TPalaceData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.Palace.Components.TUIPalaceReward;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_PALACE;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowPalaceExplanation extends TProcessorWindowTemplate
   {
      
      protected const STRING_TipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.DRAGON_STRING_06,CONST_SYSTEMLANGUAGE.DRAGON_STRING_07,CONST_SYSTEMLANGUAGE.DRAGON_STRING_08,CONST_SYSTEMLANGUAGE.DRAGON_STRING_09]);
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FMC_Rankings:SimpleButton;
      
      protected var FMC_Rewards:Vector.<TUIPalaceReward>;
      
      protected var FEliteRecord:TEliteRecord;
      
      protected var FPalaceData:TPalaceData;
      
      protected var FHint:THint;
      
      protected var FCloseTimeArr:Vector.<uint>;
      
      protected var FLookRankingsOnClick:Function;
      
      protected var FUIHintOnOver:Function;
      
      protected var FUIHintOnOut:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      public function TProcessorWindowPalaceExplanation(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Rewards = new Vector.<TUIPalaceReward>(CONST_PALACE.CAPACITY_Boxes);
         this.FEliteRecord = SLogicsCore.EliteRecord;
         this.FPalaceData = SLogicsCore.PalaceData;
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PALACE.RESOURCESID_Swf_Palace);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIPalaceReward = null;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_PALACE.RESOURCE_ClassName_MC_PalaceExplanation) as Sprite;
         UIDispatch();
         this.FTF_Date = FMainUI["TF_Date"];
         this.FTF_Desc = FMainUI["TF_Desc"];
         this.FMC_Rankings = FMainUI["MC_Rankings"];
         _loc2_ = CONST_PALACE.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIPalaceReward(this);
            _loc3_.Tag = _loc1_;
            _loc3_.Resource = FMainUI["MC_Reward_" + _loc1_] as MovieClip;
            _loc3_.UIHintOnOver = this.ProcessorUIHintOnOver;
            _loc3_.UIHintOnOut = this.ProcessorUIHintOnOut;
            _loc3_.TitleHintOnOver = this.ProcessorTitleEffectOnOver;
            _loc3_.TitleHintOnOut = this.ProcessorTitleEffectOnOut;
            _loc3_.Init();
            this.FMC_Rewards[_loc1_] = _loc3_;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
         this.FMC_Rankings.addEventListener(MouseEvent.CLICK,this.MCRankingsOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         var _loc2_:TConfigValue = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.DRAGON_STRING_01) as TSystemLanguage;
         this.FTF_Desc.htmlText = _loc1_.Desc;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.Dragon_Tips_02) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Dragon_End_Time) as TConfigValue;
         this.FCloseTimeArr = _loc2_.Value as Vector.<uint>;
         super.ResourcesPerform_UIFinalize();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:Date = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Date = null;
         var _loc5_:TSystemLanguage = null;
         var _loc6_:uint = 0;
         if(!this.Visible)
         {
            return;
         }
         if(this.FTF_Date != null)
         {
            _loc1_ = new Date(STimingCore.GetClientShowTime(this.FEliteRecord.SeasonStartTime) * 1000);
            _loc4_ = new Date(STimingCore.GetServerTick() * 1000);
            _loc2_ = _loc4_.getHours();
            _loc3_ = _loc4_.getMinutes();
            if(_loc1_.getDate() == _loc4_.getDate() || _loc4_.getDate() == _loc1_.getDate() + 1)
            {
               _loc6_ = CONST_SYSTEMLANGUAGE.DRAGON_STRING_02;
            }
            else if(_loc2_ < this.FCloseTimeArr[0] || _loc2_ == this.FCloseTimeArr[0] && _loc3_ <= this.FCloseTimeArr[1])
            {
               _loc6_ = Boolean(SLogicsCore.PalaceData.TargetFighters.RoleCurrentRank) ? CONST_SYSTEMLANGUAGE.DRAGON_STRING_03 : CONST_SYSTEMLANGUAGE.DRAGON_STRING_04;
            }
            else if(_loc2_ == 0 && _loc3_ == 45)
            {
               this.FTF_Date.text = "";
            }
            else if(this.FPalaceData.StatusValue == CONST_PALACE.STATUS_Close)
            {
               _loc6_ = CONST_SYSTEMLANGUAGE.DRAGON_STRING_05;
            }
            _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc6_) as TSystemLanguage;
            if(_loc5_ != null)
            {
               this.FTF_Date.text = _loc5_.Desc;
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIPalaceReward = null;
         var _loc4_:TGSPVP_Reward = null;
         _loc2_ = CONST_PALACE.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_Rewards[_loc1_];
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_GSPVP_Reward,CONST_PALACE.GSPVP_Identifiers[_loc1_]) as TGSPVP_Reward;
            _loc3_.Context = _loc4_;
            _loc3_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateTextFeildInfo() : void
      {
      }
      
      protected function ProcessorUIHintOnOver(param1:Object, param2:int) : void
      {
         var _loc3_:TSystemLanguage = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_TipsVec[param2]) as TSystemLanguage;
         this.FHint.Content = _loc3_.Desc;
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,this.FHint);
         }
      }
      
      protected function ProcessorUIHintOnOut(param1:Object) : void
      {
         if(FOnHelpTipsOut != null)
         {
            FOnHelpTipsOut(this);
         }
      }
      
      protected function MCRankingsOnClick(param1:MouseEvent) : void
      {
         if(this.FLookRankingsOnClick != null)
         {
            this.FLookRankingsOnClick(this);
         }
      }
      
      protected function ProcessorTitleEffectOnOver(param1:Object, param2:uint) : void
      {
         if(this.FTitleHintOnOver != null)
         {
            this.FTitleHintOnOver(this,param2);
         }
      }
      
      protected function ProcessorTitleEffectOnOut(param1:Object) : void
      {
         if(this.FTitleHintOnOut != null)
         {
            this.FTitleHintOnOut(this);
         }
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
      
      public function get LookRankingsOnClick() : Function
      {
         return this.FLookRankingsOnClick;
      }
      
      public function set LookRankingsOnClick(param1:Function) : void
      {
         this.FLookRankingsOnClick = param1;
      }
      
      public function get TitleHintOnOver() : Function
      {
         return this.FTitleHintOnOver;
      }
      
      public function set TitleHintOnOver(param1:Function) : void
      {
         this.FTitleHintOnOver = param1;
      }
      
      public function get TitleHintOnOut() : Function
      {
         return this.FTitleHintOnOut;
      }
      
      public function set TitleHintOnOut(param1:Function) : void
      {
         this.FTitleHintOnOut = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
   }
}

