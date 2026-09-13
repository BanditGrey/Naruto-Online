package Processors.Game.Lobby.Mentorship.Components
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSlaveBleed;
   import Logics.DatebaseVO.VO.TSlaveGainExp;
   import Logics.Mentorship.Elements.TDisciple;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.TProcessorGame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MENTORSHIP;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_Mentorship;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TDiscipleStatus extends TProcessorGame
   {
      
      public static const STAGE_Width:Number = CONST_COMMON.STAGE_Width;
      
      public static const STAGE_Height:Number = CONST_COMMON.STAGE_Height;
      
      protected var FHeroInfo:THeroInfo;
      
      protected var FMC_InteractionCDTime:Sprite;
      
      protected var FTF_InteractionCDTime:TextField;
      
      protected var FBTN_Interaction:MovieClip;
      
      protected var FBTN_GetDisciple:MovieClip;
      
      protected var FMC_Operation:Sprite;
      
      protected var FMC_WorkExp:Sprite;
      
      protected var FTF_WorkTime:TextField;
      
      protected var FTF_GetEXP:TextField;
      
      protected var FBTN_Draw:MovieClip;
      
      protected var FBTN_Squeeze:MovieClip;
      
      protected var FBTN_DrawAll:MovieClip;
      
      protected var FBTN_Release:MovieClip;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FDisciple:TDisciple;
      
      protected var FBTNList:Vector.<MovieClip>;
      
      protected var FInitialized:Boolean;
      
      protected var FDrawTime:uint;
      
      protected var FCommandType:uint;
      
      protected var FResource:MovieClip;
      
      protected var FOnArrest:Function;
      
      protected var FOnInteraction:Function;
      
      protected var FOnDrawExp:Function;
      
      protected var FOnRelease:Function;
      
      protected var FOnEffectGenerateText:Function;
      
      protected var FOnWatchOhterPlayerInfo:Function;
      
      public function TDiscipleStatus(param1:TUIComponent)
      {
         super(param1);
         this.FBTNList = new Vector.<MovieClip>();
         this.FInitialized = false;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TSlaveGainExp = null;
         var _loc5_:int = 0;
         var _loc6_:TConfigValue = null;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         if(!this.Parent.Visible)
         {
            return;
         }
         if(this.FDisciple == null)
         {
            return;
         }
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Slave_InteractionCDTime) as TConfigValue;
         _loc3_ = uint(STimingCore.GetServerTick());
         _loc1_ = this.FDisciple.InteractionCDTime + uint(_loc6_.Value) * 60;
         _loc2_ = this.FDisciple.StartWorkTime;
         if(this.FInitialized)
         {
            _loc5_ = _loc1_ - _loc3_;
            if(_loc5_ < 0)
            {
               if(this.FMC_InteractionCDTime.visible)
               {
                  this.FMC_InteractionCDTime.visible = false;
                  this.FBTN_Interaction.visible = true;
               }
            }
            else
            {
               if(!this.FMC_InteractionCDTime.visible)
               {
                  this.FMC_InteractionCDTime.visible = true;
                  this.FBTN_Interaction.visible = false;
               }
               this.FTF_InteractionCDTime.text = TGameUtil.fomatTime(_loc5_).toString();
            }
            if(_loc2_ != 0)
            {
               this.FTF_WorkTime.text = TGameUtil.fomatTime(_loc3_ - _loc2_);
            }
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SlaveGainExp,this.FDisciple.DiscipleLevel) as TSlaveGainExp;
            _loc7_ = _loc3_ - this.FDisciple.DrawTime;
            _loc8_ = _loc4_.Pressible / 24 / 60 / 60;
            if(_loc7_ < 0)
            {
               _loc7_ = 0;
            }
            this.FTF_GetEXP.text = "" + (uint(_loc7_ * _loc8_) + this.FDisciple.AddUpExp);
         }
         super.LogicsPerform();
      }
      
      protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         this.FHeroInfo = new THeroInfo(this);
         this.FHeroInfo.Resource = this.FResource[CONST_MENTORSHIP.RESOURCE_Link_MC_Hero];
         this.FHeroInfo.ImageOnClick = this.ProcessorOnWatchHeroInfo;
         this.FHeroInfo.Init();
         this.FMC_InteractionCDTime = this.FResource[CONST_MENTORSHIP.RESOURCE_Link_MC_InteractionCDTime];
         this.FTF_InteractionCDTime = this.FMC_InteractionCDTime[CONST_MENTORSHIP.RESOURCE_Link_TF_InteractionCDTime];
         this.FBTN_Interaction = this.FResource[CONST_MENTORSHIP.RESOURCE_Link_BTN_Interaction];
         this.FBTN_GetDisciple = this.FResource[CONST_MENTORSHIP.RESOURCE_Link_BTN_GetDisciple];
         this.FMC_Operation = this.FResource[CONST_MENTORSHIP.RESOURCE_Link_MC_Operation];
         this.FMC_WorkExp = this.FMC_Operation[CONST_MENTORSHIP.RESOURCE_Link_MC_WorkExp];
         this.FTF_WorkTime = this.FMC_WorkExp[CONST_MENTORSHIP.RESOURCE_Link_TF_WorkTime];
         this.FTF_GetEXP = this.FMC_WorkExp[CONST_MENTORSHIP.RESOURCE_Link_TF_GetEXP];
         this.FBTN_Draw = this.FMC_Operation[CONST_MENTORSHIP.RESOURCE_Link_BTN_Draw];
         this.FBTN_Squeeze = this.FMC_Operation[CONST_MENTORSHIP.RESOURCE_Link_BTN_Squeeze];
         this.FBTN_DrawAll = this.FMC_Operation[CONST_MENTORSHIP.RESOURCE_Link_BTN_DrawAll];
         this.FBTN_Release = this.FMC_Operation[CONST_MENTORSHIP.RESOURCE_Link_BTN_Release];
         this.FBTNList.push(this.FBTN_Interaction);
         this.FBTNList.push(this.FBTN_GetDisciple);
         this.FBTNList.push(this.FBTN_Draw);
         this.FBTNList.push(this.FBTN_Squeeze);
         this.FBTNList.push(this.FBTN_DrawAll);
         this.FBTNList.push(this.FBTN_Release);
         _loc2_ = this.FBTNList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            TGameUtil.setButtonMode(this.FBTNList[_loc1_],true);
            _loc1_++;
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         this.FUIWindowConfirmation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.ShowUI(false);
         this.FInitialized = true;
      }
      
      protected function UILocation() : void
      {
         this.FBTN_Interaction.addEventListener(MouseEvent.CLICK,this.BTNInteractionOnClick,false,0,true);
         this.FBTN_GetDisciple.addEventListener(MouseEvent.CLICK,this.BTN_GetDiscipleOnClick,false,0,true);
         this.FBTN_Draw.addEventListener(MouseEvent.CLICK,this.BTNDrawOnClick,false,0,true);
         this.FBTN_Squeeze.addEventListener(MouseEvent.CLICK,this.BTNSqueezeOnClick,false,0,true);
         this.FBTN_DrawAll.addEventListener(MouseEvent.CLICK,this.BTNDrawAllOnClick,false,0,true);
         this.FBTN_Release.addEventListener(MouseEvent.CLICK,this.BTNReleaseOnClick,false,0,true);
      }
      
      protected function ShowUI(param1:Boolean) : void
      {
         this.FHeroInfo.Resource.visible = param1;
         this.FBTN_Interaction.visible = param1;
         this.FMC_InteractionCDTime.visible = param1;
         this.FMC_Operation.visible = param1;
         this.FBTN_GetDisciple.visible = !param1;
      }
      
      protected function UpdateUI(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(this.FDisciple == null)
         {
            return;
         }
         this.FHeroInfo.Update(this.FDisciple);
         if(this.FDisciple.InteractionCDTime != 0)
         {
            this.FBTN_Interaction.visible = !param1;
            this.FMC_InteractionCDTime.visible = param1;
         }
         else
         {
            this.FBTN_Interaction.visible = param1;
            this.FMC_InteractionCDTime.visible = !param1;
         }
      }
      
      protected function BTNInteractionOnClick(param1:MouseEvent) : void
      {
         if(this.FOnInteraction != null)
         {
            this.FOnInteraction(this,this.FDisciple);
         }
      }
      
      protected function BTN_GetDiscipleOnClick(param1:MouseEvent) : void
      {
         if(this.FOnArrest != null)
         {
            this.FOnArrest(this);
         }
      }
      
      protected function BTNDrawOnClick(param1:MouseEvent) : void
      {
         this.FDrawTime = STimingCore.GetServerTick();
         if(this.FOnDrawExp != null)
         {
            this.FOnDrawExp(this,CONST_MENTORSHIP.COMMAND_Draw,0,this.FDisciple);
         }
      }
      
      protected function BTNSqueezeOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TSlaveBleed = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SlaveBleed,1) as TSlaveBleed;
         this.FCommandType = CONST_MENTORSHIP.COMMAND_Squeeze;
         this.FUIWindowConfirmation.Visible = true;
         this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Mentorship_Press).DescribeString,_loc2_.Cost,1);
      }
      
      protected function BTNDrawAllOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TSlaveBleed = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc3_ = this.FDisciple.StartWorkTime + 24 * 60 * 60 - this.FDisciple.DrawTime;
         _loc4_ = Math.ceil(_loc3_ / 60 / 60);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SlaveBleed,_loc4_) as TSlaveBleed;
         _loc5_ = _loc2_.Cost;
         this.FCommandType = CONST_MENTORSHIP.COMMAND_DrawAll;
         this.FUIWindowConfirmation.Visible = true;
         this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Mentorship_Drained).DescribeString,_loc5_);
      }
      
      protected function BTNReleaseOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Slave_InteractionCDTime) as TConfigValue;
         if(STimingCore.GetServerTick() - this.FDisciple.InteractionCDTime > uint(_loc2_.Value) * 60)
         {
            this.FOnEffectGenerateText(this,STRING_Mentorship.STRING_InteractionCDColding);
         }
         this.FCommandType = CONST_MENTORSHIP.COMMAND_Release;
         this.FUIWindowConfirmation.Visible = true;
         this.FUIWindowConfirmation.Text = STRING_Mentorship.STRING_Release;
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FOnDrawExp != null)
         {
            this.FOnDrawExp(this,this.FCommandType,0,this.FDisciple);
         }
      }
      
      protected function ProcessorOnWatchHeroInfo(param1:Object, param2:Object) : void
      {
         var _loc3_:TDisciple = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         if(param2 is TDisciple)
         {
            _loc3_ = param2 as TDisciple;
            _loc4_ = _loc3_.DiscipleID0;
            _loc5_ = _loc3_.DiscipleID1;
         }
         if(this.FOnWatchOhterPlayerInfo != null)
         {
            this.FOnWatchOhterPlayerInfo(this,_loc4_,_loc5_);
         }
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get OnArrest() : Function
      {
         return this.FOnArrest;
      }
      
      public function set OnArrest(param1:Function) : void
      {
         this.FOnArrest = param1;
      }
      
      public function get OnInteraction() : Function
      {
         return this.FOnInteraction;
      }
      
      public function set OnInteraction(param1:Function) : void
      {
         this.FOnInteraction = param1;
      }
      
      public function get OnDrawExp() : Function
      {
         return this.FOnDrawExp;
      }
      
      public function set OnDrawExp(param1:Function) : void
      {
         this.FOnDrawExp = param1;
      }
      
      public function get OnRelease() : Function
      {
         return this.FOnRelease;
      }
      
      public function set OnRelease(param1:Function) : void
      {
         this.FOnRelease = param1;
      }
      
      public function get OnEffectGenerateText() : Function
      {
         return this.FOnEffectGenerateText;
      }
      
      public function set OnEffectGenerateText(param1:Function) : void
      {
         this.FOnEffectGenerateText = param1;
      }
      
      public function get OnWatchOhterPlayerInfo() : Function
      {
         return this.FOnWatchOhterPlayerInfo;
      }
      
      public function set OnWatchOhterPlayerInfo(param1:Function) : void
      {
         this.FOnWatchOhterPlayerInfo = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocation();
      }
      
      public function Update(param1:TDisciple, param2:Boolean = false) : void
      {
         this.FDisciple = param1;
         this.ShowUI(param2);
         this.UpdateUI(param2);
      }
   }
}

