package Processors.Game.Battle
{
   import Components.Standard.*;
   import Components.Standard.Gauge.TUIGauge;
   import Components.Standard.Gauge.TUIGaugeHorizontal;
   import Foundation.Common.*;
   import Foundation.LoaderQueue.SLoaderProgress;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.SWF.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TProcessorBattleLoading extends TProcessor
   {
      
      protected static const STRING_ModuleLoad:String = STRING_LOADING.STRING_ModuleLoad;
      
      protected var FMax:int;
      
      protected var FCurrent:int;
      
      protected var FUIGaugeHorizontal:TUIGaugeHorizontal;
      
      protected var FTexture:TTexture;
      
      protected var FNextTexture:TTexture;
      
      protected var FCurTextureId:uint;
      
      protected var FTempTextureId:uint;
      
      protected var FBackground:TUIImage;
      
      protected var FMC_Loading:Sprite;
      
      protected var FMC_Head:Sprite;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FTF_ProgressSmall:TextField;
      
      protected var FMC_Fading:MovieClip;
      
      protected var FMC_LoadingSmallPanel:Sprite;
      
      protected var FTF_LoadingTips:TextField;
      
      protected var FStartLoading:Boolean;
      
      protected var FOnLoadingCompleted:Function;
      
      protected var FOnUnLoadingCompleted:Function;
      
      protected var FIsRandom:Boolean = true;
      
      public function TProcessorBattleLoading(param1:TUIComponent)
      {
         super(param1);
         this.FBackground = new TUIImage(this);
         Visible = false;
         this.FStartLoading = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         var _loc1_:int = Math.random() * STRING_LOBBY.RESOURCESID_Textures_BattleLoadingBackgroudVec.length;
         this.FCurTextureId = CONST_PLATE.GetBattleLoadingID(_loc1_);
         SResourcesCore.TexturesSwfVital.LoadPrimary(CONST_LOADING.RESOURCESID_SwfVital_Loading);
         SResourcesCore.TexturesLobby.LoadPrimary(this.FCurTextureId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.Loading)
         {
            return;
         }
         super.ResourcesPerform_UIWait();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:Sprite = null;
         this.FTexture = SResourcesCore.TexturesLobby.GetTextureByIdentifier(this.FCurTextureId);
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
         _loc1_ = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_MC_ProgressSmallBar01];
         this.FTF_LoadingTips = this.FMC_LoadingSmallPanel[CONST_LOADING.RESOURCE_Link_TF_LoadingTips];
         this.FBackground.Sequence = this.FTexture.GetAnimationSequenceByIndex(0);
         this.FBackground.X = (CONST_COMMON.STAGE_Width - this.FBackground.Width) / 2;
         this.FBackground.Y = (CONST_COMMON.STAGE_Height - this.FBackground.Height) / 2;
         this.FMC_Fading.visible = false;
         this.FMC_Head.visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.Visible && this.FStartLoading)
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
            }
            this.ProcessorLoadingCompleted();
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
         var _loc2_:int = 0;
         if(param1)
         {
            if(this.FMC_Effect)
            {
               this.FMC_Effect.play();
            }
            if(this.FMC_Fading)
            {
               this.FMC_Fading.play();
            }
            if(this.FIsRandom)
            {
               this.FIsRandom = false;
               _loc2_ = Math.random() * STRING_LOBBY.RESOURCESID_Textures_BattleLoadingBackgroudVec.length;
               this.FCurTextureId = CONST_PLATE.GetBattleLoadingID(_loc2_);
               SResourcesCore.TexturesLobby.LoadPrimary(this.FCurTextureId);
               this.FNextTexture = SResourcesCore.TexturesLobby.GetTextureByIdentifier(this.FCurTextureId);
            }
            this.FNextTexture = SResourcesCore.TexturesLobby.GetTextureByIdentifier(this.FCurTextureId);
            if(this.FNextTexture)
            {
               if(this.FNextTexture.GetAnimationSequenceByIndex(0).GetAnimationFrameByTick(0) != null)
               {
                  this.FBackground.Sequence = this.FNextTexture.GetAnimationSequenceByIndex(0);
                  _loc2_ = Math.random() * STRING_LOBBY.RESOURCESID_Textures_BattleLoadingBackgroudVec.length;
                  this.FCurTextureId = CONST_PLATE.GetBattleLoadingID(_loc2_);
                  SResourcesCore.TexturesLobby.LoadPrimary(this.FCurTextureId);
               }
            }
            else if(Boolean(this.FTexture) && this.FTexture.GetAnimationSequenceByIndex(0).GetAnimationFrameByTick(0) != null)
            {
               this.FBackground.Sequence = this.FTexture.GetAnimationSequenceByIndex(0);
            }
            this.FNextTexture = SResourcesCore.TexturesLobby.GetTextureByIdentifier(this.FCurTextureId);
            if(this.FTF_LoadingTips != null)
            {
               this.FTF_LoadingTips.text = STRING_LOADING.STRING_LoadingTips[TUtilityMath.RandomRange(0,STRING_LOADING.STRING_LoadingTips.length - 1)];
            }
         }
         else
         {
            if(this.FMC_Effect)
            {
               this.FMC_Effect.stop();
            }
            if(this.FMC_Fading)
            {
               this.FMC_Fading.stop();
            }
         }
      }
      
      protected function ProcessorLoadingCompleted() : void
      {
         if(this.FOnLoadingCompleted != null)
         {
            this.FOnLoadingCompleted(this);
         }
      }
      
      protected function ProcessorOnChange() : void
      {
         this.FUIGaugeHorizontal.Value = SLoaderProgress.BytesLoaded;
         this.FUIGaugeHorizontal.Maximum = SLoaderProgress.BytesTotal;
         this.FUIGaugeHorizontal.Update();
      }
      
      protected function ProcessorOnComplete() : void
      {
         SLoaderProgress.OnComplete = null;
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
      
      public function get OnUnLoadingCompleted() : Function
      {
         return this.FOnUnLoadingCompleted;
      }
      
      public function set OnUnLoadingCompleted(param1:Function) : void
      {
         this.FOnUnLoadingCompleted = param1;
      }
      
      public function StartLoading() : void
      {
         SLoaderProgress.OnChange = this.ProcessorOnChange;
         SLoaderProgress.OnComplete = this.ProcessorOnComplete;
         this.PlayEffects();
         Visible = true;
         this.FStartLoading = true;
      }
      
      public function EndLoading() : void
      {
         this.PlayEffects(false);
         SLoaderProgress.Clear();
         SLoaderProgress.OnChange = null;
         this.FUIGaugeHorizontal.Reset();
         Visible = false;
         this.FStartLoading = false;
      }
      
      override public function Dispose() : void
      {
         this.PlayEffects(false);
         this.FBackground.Dispose();
         this.FMC_Loading = null;
         this.FMC_Head = null;
         this.FMC_Effect = null;
         this.FTF_ProgressSmall = null;
         this.FMC_Fading = null;
         this.FMC_LoadingSmallPanel = null;
      }
   }
}

