package Processors.Game.Lobby.ModuleLoader
{
   import Components.Standard.Gauge.TUIGauge;
   import Components.Standard.Gauge.TUIGaugeHorizontal;
   import Foundation.LoaderQueue.SLoaderProgress;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Agent.SParametersCore;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.text.*;
   import ghostcat.operation.*;
   import ghostcat.util.easing.*;
   
   public class TProcessorModuleLoader extends TProcessorLobbyWindows
   {
      
      protected static const STRING_ModuleLoad:String = STRING_LOADING.STRING_ModuleLoad;
      
      protected var FRepeatOper:RepeatOper;
      
      protected var FTweenOperIn:TweenOper;
      
      protected var FTweenOperOut:TweenOper;
      
      protected var FMax:int;
      
      protected var FCurrent:int;
      
      protected var FUIGaugeHorizontal:TUIGaugeHorizontal;
      
      protected var FMC_Loading:Sprite;
      
      protected var FMC_Head:Sprite;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_LoadingSmallPanel:Sprite;
      
      protected var FTF_ProgressSmall:TextField;
      
      protected var FMC_Fading:MovieClip;
      
      protected var FTF_LoadingTips:TextField;
      
      protected var FIsStart:Boolean;
      
      protected var FIsLoadingCompleted:Boolean;
      
      public function TProcessorModuleLoader(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         FBoundsClient.Width = CONST_COMMON.STAGE_Width;
         FBoundsClient.Height = CONST_COMMON.STAGE_Height;
         this.ConstructTweens();
         this.FIsStart = false;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.FIsLoadingCompleted = false;
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      protected function ConstructTweens() : void
      {
         this.FRepeatOper = new RepeatOper();
         this.FTweenOperIn = new TweenOper();
         this.FTweenOperOut = new TweenOper();
         this.FTweenOperIn.duration = 300;
         this.FTweenOperIn.target = this;
         this.FTweenOperOut.duration = 300;
         this.FTweenOperOut.target = this;
         this.FRepeatOper.loop = 1;
         this.FRepeatOper.children = [this.FTweenOperIn,this.FTweenOperOut];
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfVital.LoadPrimary(CONST_LOADING.RESOURCESID_SwfVital_Loading);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         this.FMC_Loading = TUtilityReflection.CreateDisplayObjectInstance(CONST_LOADING.RESOURCE_ClassName_MC_Loading) as Sprite;
         addChild(this.FMC_Loading);
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
         this.FMC_LoadingSmallPanel = this.FMC_Loading[CONST_LOADING.RESOURCE_Link_MC_LoadingSmallPanel];
         this.FMC_Fading = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_MC_Fading];
         this.FTF_ProgressSmall = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_TF_ProgressSmall];
         _loc1_ = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_MC_ProgressSmallBar01];
         this.FTF_LoadingTips = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_TF_LoadingTips];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Loading.x = (CONST_COMMON.STAGE_Width - this.FMC_Loading.width) / 2 + 150;
         this.FMC_Loading.y = (CONST_COMMON.STAGE_Height - this.FMC_Loading.height) / 2 + 80;
         this.FIsLoadingCompleted = true;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FIsLoadingCompleted && this.FIsStart)
         {
            if(SLoaderProgress.OnChange == null || SLoaderProgress.OnComplete == null)
            {
               SLoaderProgress.OnChange = this.ProcessorOnChange;
               SLoaderProgress.OnComplete = this.ProcessorOnComplete;
            }
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
               this.PlayEffects(false);
            }
         }
         else
         {
            if(this.FCurrent == 0)
            {
               this.FUIGaugeHorizontal.Reset();
               SLoaderProgress.Start();
               this.PlayEffects();
            }
            if(_loc1_ > this.FMax)
            {
               this.FMax = _loc1_;
            }
            this.FCurrent = _loc1_;
         }
         if(this.FTF_ProgressSmall == null)
         {
            return;
         }
         if(this.FMax != 0)
         {
            SLoaderProgress.Max = this.FMax;
            this.FTF_ProgressSmall.text = TUtilityString.Format(STRING_ModuleLoad,this.FMax - this.FCurrent + 1,this.FMax);
         }
      }
      
      protected function PlayEffects(param1:Boolean = true) : void
      {
         if(!this.FIsLoadingCompleted)
         {
            return;
         }
         if(param1)
         {
            this.Show();
         }
         else
         {
            this.Hide();
         }
      }
      
      protected function Show() : void
      {
         this.FTweenOperIn.params = {
            "alpha":this.alpha,
            "ease":Cubic.easeInOut,
            "onStartHandler":this.PerformTweenOperOnStart
         };
         this.FTweenOperOut.params = {
            "alpha":1,
            "ease":Cubic.easeInOut,
            "onCompleteHandler":this.PerformTweenOperOnStart
         };
         this.FRepeatOper.execute();
      }
      
      protected function Hide() : void
      {
         this.FRepeatOper.halt();
         this.FTweenOperIn.params = {
            "alpha":this.alpha,
            "ease":Cubic.easeInOut,
            "onStartHandler":this.PerformTweenOperOnStart
         };
         this.FTweenOperOut.params = {
            "alpha":0,
            "ease":Cubic.easeInOut,
            "onCompleteHandler":this.PerformTweenOperOnComplete
         };
         this.FRepeatOper.execute();
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
      }
      
      protected function PerformTweenOperOnStart(param1:TweenEvent) : void
      {
         if(!Visible)
         {
            this.FMC_Effect.play();
            this.FMC_Fading.play();
            if(SParametersCore.AgentID != CONST_PLATE.ID_PLATE_RUSSIA && this.FTF_LoadingTips != null)
            {
               this.FTF_LoadingTips.text = STRING_LOADING.STRING_LoadingTips[TUtilityMath.RandomRange(0,STRING_LOADING.STRING_LoadingTips.length - 1)];
            }
            BarrierActuate(this);
            Visible = true;
         }
      }
      
      protected function PerformTweenOperOnComplete(param1:TweenEvent) : void
      {
         if(Visible)
         {
            this.FMC_Effect.stop();
            this.FMC_Fading.stop();
            BarrierDeactuate(this);
            this.Visible = false;
         }
      }
      
      public function Start() : void
      {
         this.FIsStart = true;
      }
      
      public function Stop() : void
      {
         this.FIsStart = false;
      }
   }
}

