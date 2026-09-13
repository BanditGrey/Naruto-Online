package Rendering.Overlayers.CrossServerWar
{
   import Components.Standard.TUIImage;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TAnimationSequence;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.CrossServerWar.TChallengePlayer;
   import Logics.SLogicsCore;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Texts.TPainterTextEffect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_OVERLAYERCROSSSERVERWAR;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class TOverLayerCrossServerPlayerInfo extends TOverlayer
   {
      
      protected static const SIZE_DividingLineOffset:uint = 3;
      
      protected static const CAPACITY_HeroHeads:uint = 4;
      
      protected static const SIZE_Image_Width:uint = 80;
      
      protected static const SIZE_Image_Height:uint = 70;
      
      protected static const SIZE_Context_00:uint = 18;
      
      protected static const SIZE_Padding_01:uint = 3;
      
      protected static const SIZE_Padding_02:uint = 10;
      
      protected static const SIZE_Padding_03:uint = 15;
      
      protected static const COLOR_Context_White:uint = 4294967295;
      
      protected static const COLOR_Context_Invalid:uint = 4286611584;
      
      protected static const COLOR_Context_03:uint = 4294890346;
      
      protected static const COLOR_Context_04:uint = 16737792;
      
      protected static const COLOR_Context_Green:uint = 4284940032;
      
      protected static const SIZE_DividingLine_Max_Width:uint = 250;
      
      protected static const SIZE_DividingLine_Min_Width:uint = 240;
      
      protected var FPainterHeroName:TPainterTextEffect;
      
      protected var FPainterHeroLevel:TPainterTextEffect;
      
      protected var FPainterServerName:TPainterTextEffect;
      
      protected var FPainterFightingPower:TPainterTextEffect;
      
      protected var FPainterHeroCaption:TPainterTextEffect;
      
      protected var FPainterHeroNames:Vector.<TPainterTextEffect>;
      
      protected var FPainterPetLevel:TPainterTextEffect;
      
      protected var FPainterScores:TPainterTextEffect;
      
      protected var FQuerySequenceTimer:Timer;
      
      protected var FImages:Vector.<TUIImage>;
      
      protected var FMC_DefaultIcons:Vector.<MovieClip>;
      
      protected var FBoundsHeroName:TBounds;
      
      protected var FBoundsHeroLevel:TBounds;
      
      protected var FBoundsServerName:TBounds;
      
      protected var FBoundsFightingPower:TBounds;
      
      protected var FBoundsHeroCaption:TBounds;
      
      protected var FBoundsImages:Vector.<TBounds>;
      
      protected var FBoundsHeroNames:Vector.<TBounds>;
      
      protected var FBoundsPetLevel:TBounds;
      
      protected var FBoundsScores:TBounds;
      
      protected var FTextFormatHeroName:TextFormat;
      
      protected var FTextFormatServerName:TextFormat;
      
      protected var FTextFormatFightingPower:TextFormat;
      
      protected var FTextFormatHeroNames:TextFormat;
      
      protected var FTextFormatPetLevel:TextFormat;
      
      protected var FTextFormatScores:TextFormat;
      
      protected var FDividingLinePartCaption:Bitmap;
      
      protected var FDividingLinePartHeroHead:Bitmap;
      
      protected var FBoundsPartCaption:TBounds;
      
      protected var FBoundsPartHeroHead:TBounds;
      
      protected var FModuleId:uint;
      
      protected var FBoundsOffset:TBounds;
      
      public function TOverLayerCrossServerPlayerInfo(param1:TUIComponent, param2:uint)
      {
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TBounds = null;
         var _loc6_:TUIImage = null;
         var _loc7_:TPainterTextEffect = null;
         super(param1);
         this.FModuleId = param2;
         this.FPainterHeroName = ConstructPainterTextEffect(COLOR_Context_04);
         this.FBoundsHeroName = new TBounds();
         this.FPainterHeroLevel = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsHeroLevel = new TBounds();
         this.FPainterServerName = ConstructPainterTextEffect(COLOR_Context_Green);
         this.FBoundsServerName = new TBounds();
         this.FPainterFightingPower = ConstructPainterTextEffect(COLOR_Context_03);
         this.FBoundsFightingPower = new TBounds();
         this.FPainterHeroCaption = ConstructPainterTextEffect(COLOR_Context_White);
         this.FBoundsHeroCaption = new TBounds();
         this.FDividingLinePartCaption = new Bitmap();
         addChild(this.FDividingLinePartCaption);
         this.FBoundsPartCaption = new TBounds();
         this.FDividingLinePartHeroHead = new Bitmap();
         addChild(this.FDividingLinePartHeroHead);
         this.FBoundsPartHeroHead = new TBounds();
         this.FImages = new Vector.<TUIImage>();
         this.FMC_DefaultIcons = new Vector.<MovieClip>();
         this.FBoundsImages = new Vector.<TBounds>();
         this.FPainterHeroNames = new Vector.<TPainterTextEffect>();
         this.FBoundsHeroNames = new Vector.<TBounds>();
         _loc3_ = 0;
         while(_loc3_ < CAPACITY_HeroHeads)
         {
            _loc5_ = new TBounds();
            _loc7_ = ConstructPainterTextEffect(COLOR_Context_White);
            this.FPainterHeroNames[_loc3_] = _loc7_;
            this.FBoundsHeroNames[_loc3_] = _loc5_;
            _loc6_ = new TUIImage(this);
            _loc6_.scaleX = 0.5;
            _loc6_.scaleY = 0.5;
            this.FImages[_loc3_] = _loc6_;
            _loc4_ = new TBounds();
            this.FBoundsImages[_loc3_] = _loc4_;
            _loc3_++;
         }
         this.FPainterPetLevel = ConstructPainterTextEffect(COLOR_Context_03);
         this.FBoundsPetLevel = new TBounds();
         this.FPainterScores = ConstructPainterTextEffect(COLOR_Context_03);
         this.FBoundsScores = new TBounds();
         this.FTextFormatHeroName = new TextFormat();
         this.FTextFormatServerName = new TextFormat();
         this.FTextFormatFightingPower = new TextFormat();
         this.FTextFormatHeroNames = new TextFormat();
         this.FTextFormatPetLevel = new TextFormat();
         this.FTextFormatScores = new TextFormat();
         this.FQuerySequenceTimer = new Timer(500,1);
         this.FQuerySequenceTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.TimeQuerySequence);
         FMarginLeft = 15;
         FMarginTop = 15;
         FMarginRight = 1;
         FMarginBottom = 15;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = CAPACITY_HeroHeads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            if(_loc3_ != null)
            {
               _loc3_.mouseEnabled = false;
               this.addChild(_loc3_);
               _loc3_.stop();
               _loc3_.visible = false;
            }
            this.FMC_DefaultIcons[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FDividingLinePartCaption.bitmapData = FDividingLine;
         this.FDividingLinePartHeroHead.bitmapData = FDividingLine;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ContextSynchronize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Min_Width;
         this.FDividingLinePartHeroHead.width = SIZE_DividingLine_Min_Width;
      }
      
      override protected function ContextModified() : Boolean
      {
         return true;
      }
      
      override protected function EvaluationPerform_Context() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TChallengePlayer = null;
         _loc3_ = FContext as TChallengePlayer;
         this.EvaluationPerform_HeroName(_loc3_);
         this.FBoundsOffset = this.FBoundsHeroName;
         this.EvaluationPerform_HeroLevel(_loc3_);
         this.FBoundsOffset = this.FBoundsHeroLevel;
         this.EvaluationPerform_ServerName(_loc3_);
         this.FBoundsOffset = this.FBoundsServerName;
         this.EvaluationPerform_FightingPower(_loc3_);
         this.FBoundsOffset = this.FBoundsFightingPower;
         this.EvaluationPerform_PartCaption(_loc3_);
         this.FBoundsOffset = this.FBoundsPartCaption;
         this.EvaluationPerform_HeroCaption(_loc3_);
         this.FBoundsOffset = this.FBoundsHeroCaption;
         this.EvaluationPerform_Icons(_loc3_);
         this.EvaluationPerform_PartHeroHead(_loc3_);
         this.FBoundsOffset = this.FBoundsPartHeroHead;
         this.EvaluationPerform_PetLevel(_loc3_);
         this.FBoundsOffset = this.FBoundsPetLevel;
         this.EvaluationPerform_Scores(_loc3_);
         this.FBoundsOffset = this.FBoundsScores;
      }
      
      protected function EvaluationPerform_Icons(param1:TChallengePlayer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:THero = null;
         var _loc5_:TUIImage = null;
         var _loc6_:TBounds = null;
         var _loc7_:TBounds = null;
         var _loc8_:TAnimationSequence = null;
         var _loc9_:MovieClip = null;
         var _loc10_:TPainterTextEffect = null;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_HeroHeads)
         {
            _loc5_ = this.FImages[_loc2_];
            _loc9_ = this.FMC_DefaultIcons[_loc2_];
            _loc10_ = this.FPainterHeroNames[_loc2_];
            _loc5_.Sequence = null;
            _loc9_.visible = false;
            _loc10_.visible = false;
            _loc2_++;
         }
         param1 = FContext as TChallengePlayer;
         _loc3_ = uint(param1.TargetHeros.Count);
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_HeroHeads)
         {
            if(_loc2_ + 1 >= _loc3_)
            {
               break;
            }
            _loc4_ = param1.TargetHeros.GetHeroByIndex(_loc2_ + 1);
            _loc8_ = SResourcesCore.TexturesHeadIcon.GetAnimationSequenceByIdentifiers(_loc4_.SmallID,0);
            _loc5_ = this.FImages[_loc2_];
            _loc9_ = this.FMC_DefaultIcons[_loc2_];
            _loc6_ = this.FBoundsImages[_loc2_];
            _loc7_ = this.FBoundsHeroNames[_loc2_];
            if(_loc2_ == 0)
            {
               BoundsAlignDown(_loc6_,this.FBoundsOffset);
            }
            else
            {
               BoundsAlignRight(_loc6_,this.FBoundsOffset,SIZE_Padding_02);
            }
            this.FBoundsOffset = _loc6_;
            if(_loc8_ != null)
            {
               _loc5_.Sequence = _loc8_;
            }
            else
            {
               _loc5_.Sequence = null;
               if(!this.FQuerySequenceTimer.running)
               {
                  this.FQuerySequenceTimer.start();
               }
               _loc9_.play();
               _loc9_.visible = true;
            }
            _loc6_.Width = SIZE_Image_Width / 2;
            _loc6_.Height = SIZE_Image_Height / 2;
            BoundsAlignDown(_loc7_,this.FBoundsOffset);
            _loc10_ = this.FPainterHeroNames[_loc2_];
            _loc10_.Text = _loc4_.Name;
            this.FTextFormatHeroNames.size = 10;
            _loc10_.Evaluate(_loc7_);
            _loc10_.SetTextFormat(this.FTextFormatHeroNames);
            BoundsContextUnion(_loc7_);
            _loc2_++;
         }
      }
      
      protected function EvaluationPerform_HeroName(param1:TChallengePlayer) : void
      {
         BoundsAlignDown(this.FBoundsHeroName);
         this.FPainterHeroName.Text = param1.TargetName;
         this.FTextFormatHeroName.size = SIZE_Context_00;
         this.FPainterHeroName.Evaluate(this.FBoundsHeroName);
         this.FPainterHeroName.SetTextFormat(this.FTextFormatHeroName);
         BoundsContextUnion(this.FBoundsHeroName);
      }
      
      protected function EvaluationPerform_HeroLevel(param1:TChallengePlayer) : void
      {
         BoundsAlignRight(this.FBoundsHeroLevel);
         this.FPainterHeroLevel.Text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.TargetLevel);
         this.FPainterHeroLevel.Evaluate(this.FBoundsHeroLevel);
         BoundsContextUnion(this.FBoundsHeroLevel);
      }
      
      protected function EvaluationPerform_ServerName(param1:TChallengePlayer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         BoundsAlignDown(this.FBoundsServerName);
         _loc2_ = 0;
         _loc3_ = int(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_ServerName_COLOR_LEGNTH);
         this.FPainterServerName.Text = TUtilityString.Format(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_ServerName,param1.TargetServerName);
         this.FTextFormatServerName.color = COLOR_Context_White;
         this.FPainterServerName.Evaluate(this.FBoundsServerName);
         this.FPainterServerName.SetTextFormat(this.FTextFormatServerName,_loc2_,_loc3_);
         BoundsContextUnion(this.FBoundsServerName);
      }
      
      protected function EvaluationPerform_FightingPower(param1:TChallengePlayer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         BoundsAlignDown(this.FBoundsFightingPower);
         _loc2_ = 0;
         _loc3_ = int(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_FightingPower_COLOR_LEGNTH);
         this.FPainterFightingPower.Text = TUtilityString.Format(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_FightingPower,param1.TargetFightingPower.ToString());
         this.FTextFormatFightingPower.color = COLOR_Context_White;
         this.FPainterFightingPower.Evaluate(this.FBoundsFightingPower);
         this.FPainterFightingPower.SetTextFormat(this.FTextFormatFightingPower,_loc2_,_loc3_);
         BoundsContextUnion(this.FBoundsFightingPower);
      }
      
      protected function EvaluationPerform_PartCaption(param1:TChallengePlayer) : void
      {
         this.FBoundsPartCaption.Width = this.FDividingLinePartCaption.width;
         this.FBoundsPartCaption.Height = this.FDividingLinePartCaption.height;
         BoundsAlignDown(this.FBoundsPartCaption);
         this.FBoundsPartCaption.X = 0;
         BoundsContextUnion(this.FBoundsPartCaption);
      }
      
      protected function EvaluationPerform_HeroCaption(param1:TChallengePlayer) : void
      {
         BoundsAlignDown(this.FBoundsHeroCaption);
         this.FPainterHeroCaption.Text = STRING_OVERLAYERCROSSSERVERWAR.STRING_Hero;
         this.FPainterHeroCaption.Evaluate(this.FBoundsHeroCaption);
         BoundsContextUnion(this.FBoundsHeroCaption);
      }
      
      protected function EvaluationPerform_PartHeroHead(param1:TChallengePlayer) : void
      {
         this.FBoundsPartHeroHead.Width = this.FDividingLinePartHeroHead.width;
         this.FBoundsPartHeroHead.Height = this.FDividingLinePartHeroHead.height;
         BoundsAlignDown(this.FBoundsPartHeroHead);
         this.FBoundsPartCaption.X = 0;
         BoundsContextUnion(this.FBoundsPartHeroHead);
      }
      
      protected function EvaluationPerform_PetLevel(param1:TChallengePlayer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         BoundsAlignDown(this.FBoundsPetLevel);
         _loc2_ = 0;
         _loc3_ = int(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_PetLevel_COLOR_LEGNTH);
         this.FPainterPetLevel.Text = TUtilityString.Format(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_PetLevel,param1.TargetPetLevel);
         this.FTextFormatPetLevel.color = COLOR_Context_White;
         this.FPainterPetLevel.Evaluate(this.FBoundsPetLevel);
         this.FPainterPetLevel.SetTextFormat(this.FTextFormatPetLevel,_loc2_,_loc3_);
         BoundsContextUnion(this.FBoundsPetLevel);
      }
      
      protected function EvaluationPerform_Scores(param1:TChallengePlayer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         BoundsAlignDown(this.FBoundsScores);
         _loc2_ = 0;
         _loc3_ = int(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_Scores_COLOR_LEGNTH);
         this.FPainterScores.Text = TUtilityString.Format(STRING_OVERLAYERCROSSSERVERWAR.FORMAT_Scores,param1.TargetScore);
         this.FTextFormatScores.color = COLOR_Context_White;
         this.FPainterScores.Evaluate(this.FBoundsScores);
         this.FPainterScores.SetTextFormat(this.FTextFormatScores,_loc2_,_loc3_);
         BoundsContextUnion(this.FBoundsScores);
      }
      
      protected function TimeQuerySequence(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TChallengePlayer = null;
         var _loc5_:THero = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TUIImage = null;
         var _loc8_:TPainterTextEffect = null;
         var _loc9_:TResourceRepositoryTexture = null;
         var _loc10_:TTexture = null;
         _loc4_ = FContext as TChallengePlayer;
         _loc3_ = uint(_loc4_.TargetHeros.Count);
         _loc9_ = SResourcesCore.TexturesHeadIcon;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_HeroHeads)
         {
            if(_loc2_ + 1 >= _loc3_)
            {
               break;
            }
            _loc5_ = _loc4_.TargetHeros.GetHeroByIndex(_loc2_ + 1);
            _loc10_ = _loc9_.GetTextureByIdentifier(_loc5_.SmallID);
            _loc6_ = this.FMC_DefaultIcons[_loc2_];
            _loc7_ = this.FImages[_loc2_];
            _loc8_ = this.FPainterHeroNames[_loc2_];
            if(_loc10_ != null)
            {
               _loc7_.Sequence = _loc10_.GetAnimationSequenceByIdentifier(0);
               if(_loc6_.visible)
               {
                  _loc6_.stop();
                  _loc6_.visible = false;
               }
               this.FQuerySequenceTimer.reset();
               this.FQuerySequenceTimer.stop();
            }
            else
            {
               _loc9_.LoadSecondary(_loc5_.SmallID,this.FModuleId);
               this.FQuerySequenceTimer.reset();
               if(!this.FQuerySequenceTimer.running)
               {
                  this.FQuerySequenceTimer.start();
               }
            }
            _loc2_++;
         }
      }
      
      override protected function RenderingPerform_Context(param1:TCoordinate) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBounds = null;
         var _loc5_:TBounds = null;
         var _loc6_:TPainterTextEffect = null;
         var _loc7_:TUIImage = null;
         var _loc8_:TChallengePlayer = null;
         _loc8_ = FContext as TChallengePlayer;
         FBoundsRendering.X = FMarginLeft;
         FBoundsRendering.Y = FMarginTop;
         this.FPainterHeroName.X = FBoundsRendering.X + this.FBoundsHeroName.X;
         this.FPainterHeroName.Y = FBoundsRendering.Y + this.FBoundsHeroName.Y;
         this.FPainterHeroLevel.X = FBoundsRendering.X + this.FBoundsHeroLevel.X + 6;
         this.FPainterHeroLevel.Y = FBoundsRendering.Y + this.FBoundsHeroLevel.Y + 3;
         this.FPainterServerName.X = FBoundsRendering.X + this.FBoundsServerName.X;
         this.FPainterServerName.Y = FBoundsRendering.Y + this.FBoundsServerName.Y;
         this.FPainterFightingPower.X = FBoundsRendering.X + this.FBoundsFightingPower.X;
         this.FPainterFightingPower.Y = FBoundsRendering.Y + this.FBoundsFightingPower.Y;
         this.FDividingLinePartCaption.x = FBoundsRendering.X + this.FBoundsPartCaption.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartCaption.y = FBoundsRendering.Y + this.FBoundsPartCaption.Y;
         this.FPainterHeroCaption.X = FBoundsRendering.X + this.FBoundsHeroCaption.X;
         this.FPainterHeroCaption.Y = FBoundsRendering.Y + this.FBoundsHeroCaption.Y + 5;
         _loc3_ = _loc8_.TargetHeros.Count;
         _loc2_ = 0;
         while(_loc2_ < CAPACITY_HeroHeads)
         {
            if(_loc2_ + 1 >= _loc3_)
            {
               break;
            }
            _loc7_ = this.FImages[_loc2_];
            _loc4_ = this.FBoundsImages[_loc2_];
            _loc6_ = this.FPainterHeroNames[_loc2_];
            _loc5_ = this.FBoundsHeroNames[_loc2_];
            _loc7_.X = FBoundsRendering.X + _loc4_.X;
            _loc7_.Y = FBoundsRendering.Y + _loc4_.Y;
            _loc6_.X = FBoundsRendering.X + _loc5_.X + (_loc4_.Width - _loc5_.Width >> 1);
            _loc6_.Y = FBoundsRendering.Y + _loc5_.Y + 4;
            _loc6_.Visible = true;
            _loc2_++;
         }
         this.FDividingLinePartHeroHead.x = FBoundsRendering.X + this.FBoundsPartHeroHead.X - FMarginLeft + SIZE_DividingLineOffset;
         this.FDividingLinePartHeroHead.y = FBoundsRendering.Y + this.FBoundsPartHeroHead.Y + 3;
         this.FPainterPetLevel.X = FBoundsRendering.X + this.FBoundsPetLevel.X;
         this.FPainterPetLevel.Y = FBoundsRendering.Y + this.FBoundsPetLevel.Y + 5;
         this.FPainterScores.X = FBoundsRendering.X + this.FBoundsScores.X;
         this.FPainterScores.Y = FBoundsRendering.Y + this.FBoundsScores.Y + 5;
         this.FDividingLinePartCaption.width = SIZE_DividingLine_Max_Width;
         this.FDividingLinePartHeroHead.width = SIZE_DividingLine_Max_Width;
      }
      
      override public function Show() : void
      {
         if(FContext == null)
         {
            return;
         }
         super.Show();
      }
   }
}

