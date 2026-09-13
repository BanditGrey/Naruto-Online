package Processors.Accessories
{
   import Components.Standard.*;
   import Components.Standard.Gauge.TUIGauge;
   import Components.Standard.Gauge.TUIGaugeHorizontal;
   import Externals.*;
   import Foundation.Common.*;
   import Foundation.LoaderQueue.SLoaderProgress;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.SWF.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Agent.SParametersCore;
   import Processors.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import ghostcat.util.easing.TweenEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorLoading extends TProcessor
   {
      
      public static const STRING_ResourcesLoad:String = STRING_LOADING.STRING_ResourcesLoad;
      
      protected var FMax:int;
      
      protected var FCurrent:int;
      
      protected var FUIGaugeHorizontal:TUIGaugeHorizontal;
      
      protected var FBackground:TUIImage;
      
      protected var FMC_Loading:Sprite;
      
      protected var FMC_Head:Sprite;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FTF_ProgressSmall:TextField;
      
      protected var FMC_Fading:MovieClip;
      
      protected var FMC_LoadingSmallPanel:Sprite;
      
      protected var FTF_LoadingTips:TextField;
      
      protected var FIsSendLoadStartStatistical:Boolean;
      
      protected var FIsSendLoadEndStatistical:Boolean;
      
      protected var FIsLoadCompleted:Boolean;
      
      protected var FTweenTick:uint;
      
      protected var FLoadingPictureId:uint;
      
      protected var FOnLoadingCompleted:Function;
      
      public function TProcessorLoading(param1:TUIComponent)
      {
         super(param1);
         this.FBackground = new TUIImage(this);
         this.FIsSendLoadStartStatistical = false;
         this.FIsSendLoadEndStatistical = false;
         this.FIsLoadCompleted = false;
         this.FTweenTick = 1900;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfVital.LoadPrimary(CONST_LOADING.RESOURCESID_SwfVital_Loading);
         SResourcesCore.TexturesLobby.LoadPrimary(this.FLoadingPictureId,CONST_MODULES.MODULE_Loading);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TTexture = null;
         var _loc3_:Sprite = null;
         _loc2_ = SResourcesCore.TexturesLobby.GetTextureByIdentifier(this.FLoadingPictureId);
         if(_loc2_)
         {
            this.FBackground.Sequence = _loc2_.GetAnimationSequenceByIndex(0);
            this.FBackground.X = (CONST_COMMON.STAGE_Width - this.FBackground.Width) / 2;
            this.FBackground.Y = (CONST_COMMON.STAGE_Height - this.FBackground.Height) / 2;
         }
         this.FMC_Loading = TUtilityReflection.CreateDisplayObjectInstance(CONST_LOADING.RESOURCE_ClassName_MC_Loading) as Sprite;
         addChild(this.FMC_Loading);
         this.FMC_Loading.x = (CONST_COMMON.STAGE_Width - this.FMC_Loading.width) / 2 + 150;
         this.FMC_Loading.y = (CONST_COMMON.STAGE_Height - this.FMC_Loading.height) / 2 + 260;
         this.FUIGaugeHorizontal = new TUIGaugeHorizontal();
         this.FUIGaugeHorizontal.Resource = this.FMC_Loading[CONST_LOADING.RESOURCE_Link_MC_ProgressBigBar01];
         this.FUIGaugeHorizontal.ModeGauge = TUIGauge.MODE_PROGRESS_PERCENTAGE;
         this.FUIGaugeHorizontal.TypeLabel = TUIGauge.TYPE_LABLE_PERCENTAGE;
         this.FUIGaugeHorizontal.IsScale = false;
         this.FUIGaugeHorizontal.IsLoadMode = true;
         this.FUIGaugeHorizontal.Minimum = 0;
         this.FUIGaugeHorizontal.Maximum = 100;
         this.FMC_Head = this.FMC_Loading[CONST_LOADING.RESOURCE_Link_MC_Head];
         this.FMC_Effect = this.FMC_Loading[CONST_LOADING.RESOURCE_Link_MC_Effect];
         this.FMC_LoadingSmallPanel = this.FMC_Loading[CONST_LOADING.RESOURCE_Link_MC_LoadingSmallPanel];
         this.FMC_Fading = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_MC_Fading];
         this.FTF_ProgressSmall = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_TF_ProgressSmall];
         this.FTF_LoadingTips = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_TF_LoadingTips];
         if(SParametersCore.AgentID != CONST_PLATE.ID_PLATE_RUSSIA && this.FTF_LoadingTips != null)
         {
            this.FTF_LoadingTips.text = STRING_LOADING.STRING_LoadingTips[TUtilityMath.RandomRange(0,STRING_LOADING.STRING_LoadingTips.length - 1)];
         }
         this.FMC_Head.visible = false;
         SLoaderProgress.OnChange = this.ProcessorOnChange;
         SLoaderProgress.OnComplete = this.ProcessorOnComplete;
         this.PlayEffects();
         if(SParametersCore.IsNewUser)
         {
            SResourcesCore.ResourceBin.LoadPrimary(CONST_DATEBASEVO.RESOURCEID_Base);
            SResourcesCore.TexturesSwfCommon.LoadPrimary(CONST_COMMON.RESOURCESID_Swf_Common);
            SResourcesCore.TexturesSwfCreateChar.LoadPrimary(CONST_ACCOUNT.RESOURCESID_Swf_Account);
         }
         this.FIsLoadCompleted = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.Visible && this.FIsLoadCompleted)
         {
            this.LogicsPerform_ProgressPercentage();
         }
      }
      
      protected function LogicsPerform_ProgressPercentage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(SResourcesCore.PrimaryCount);
         SLoaderProgress.Pendings = _loc1_;
         if(_loc1_ == 0)
         {
            if(this.FMax != 0)
            {
               this.FMax = 0;
               this.FCurrent = 0;
               this.ProcessorLoadingCompleted();
            }
         }
         else
         {
            if(this.FCurrent == 0)
            {
               SLoaderProgress.Start();
            }
            if(_loc1_ > this.FMax)
            {
               this.FMax = _loc1_;
            }
            this.FCurrent = _loc1_;
            if(!this.FIsSendLoadStartStatistical)
            {
               this.FIsSendLoadStartStatistical = true;
               SExternalCore.GameStatistical(CONST_ACCOUNT.STATISTICALSETP_LoadStart);
            }
         }
         if(this.FTF_ProgressSmall == null)
         {
            return;
         }
         if(this.FMax != 0)
         {
            SLoaderProgress.Max = this.FMax;
            this.FTF_ProgressSmall.text = TUtilityString.Format(STRING_ResourcesLoad,this.FMax - this.FCurrent + 1,this.FMax);
         }
         else if(!this.FIsSendLoadEndStatistical)
         {
            this.FIsSendLoadEndStatistical = true;
            SExternalCore.GameStatistical(CONST_ACCOUNT.STATISTICALSETP_LoadEnd);
         }
      }
      
      protected function PlayEffects(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.FMC_Effect.play();
            this.FMC_Fading.play();
         }
         else
         {
            this.FMC_Effect.stop();
            this.FMC_Fading.stop();
         }
      }
      
      protected function ProcessorLoadingCompleted() : void
      {
         if(this.FOnLoadingCompleted != null)
         {
            this.FOnLoadingCompleted(this);
         }
         TweenUtil.to(this,this.FTweenTick,{
            "alpha":0,
            "onCompleteHandler":this.PerformTweenOnComplete
         });
      }
      
      protected function ProcessorOnChange() : void
      {
         this.FUIGaugeHorizontal.Value = SLoaderProgress.BytesLoaded;
         this.FUIGaugeHorizontal.Maximum = SLoaderProgress.BytesTotal;
         this.FUIGaugeHorizontal.Update();
      }
      
      protected function ProcessorOnComplete() : void
      {
         SLoaderProgress.Clear();
         SLoaderProgress.OnChange = null;
         SLoaderProgress.OnComplete = null;
      }
      
      protected function PerformTweenOnComplete(param1:TweenEvent) : void
      {
         TweenUtil.removeAllTween();
      }
      
      public function get ResourcesLoading() : Boolean
      {
         return this.FCurrent != 0;
      }
      
      public function get OnLoadingCompleted() : Function
      {
         return this.FOnLoadingCompleted;
      }
      
      public function set OnLoadingCompleted(param1:Function) : void
      {
         this.FOnLoadingCompleted = param1;
      }
      
      public function get TweenTick() : uint
      {
         return this.FTweenTick;
      }
      
      public function set TweenTick(param1:uint) : void
      {
         this.FTweenTick = param1;
      }
      
      override public function Dispose() : void
      {
         this.PlayEffects(false);
         if(this.FBackground.Parent != null)
         {
            this.FBackground.Parent.removeChild(this.FBackground);
         }
         this.FBackground.Dispose();
         this.FBackground = null;
         this.PlayEffects(false);
         if(this.FMC_Loading.parent != null)
         {
            this.FMC_Loading.parent.removeChild(this.FMC_Loading);
         }
         this.FUIGaugeHorizontal.Dispose();
         this.FUIGaugeHorizontal = null;
         this.FMC_Head = null;
         this.FMC_Effect = null;
         this.FTF_ProgressSmall = null;
         this.FMC_Fading = null;
         this.FMC_LoadingSmallPanel = null;
         this.FTF_LoadingTips = null;
         this.FMC_Loading = null;
         SResourcesCore.PerformAutoReleaseResources(CONST_MODULES.MODULE_Loading);
      }
      
      public function set LoadingPictureId(param1:uint) : void
      {
         this.FLoadingPictureId = param1;
      }
      
      public function get LoadingPictureId() : uint
      {
         return this.FLoadingPictureId;
      }
   }
}

