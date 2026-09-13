package Processors.Game.Battle.Character
{
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Battle.model.*;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.*;
   import Logics.SLogicsCore;
   import Processors.*;
   import Processors.Game.Battle.*;
   import Processors.Game.Battle.Effect.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_BATTLE;
   import flash.display.*;
   import flash.events.*;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.*;
   import ghostcat.util.data.*;
   import ghostcat.util.easing.*;
   
   public class TActive extends TUIComponent
   {
      
      public static const Role_BaseSpeed:int = 500;
      
      public static const TYPE_ACTIVE_IDLE:int = 0;
      
      public static const TYPE_ACTIVE_FIGHT_IDLE:int = 1;
      
      public static const TYPE_ACTIVE_ATTACK:int = 2;
      
      public static const TYPE_ACTIVE_SKILL:int = 3;
      
      public static const TYPE_ACTIVE_ATTACKED:int = 4;
      
      public static const TYPE_ACTIVE_RUN:int = 5;
      
      public static const TYPE_ACTIVE_DODGE:int = 7;
      
      public static const TYPE_ACTIVE_GRIDFILE:int = 8;
      
      public static const TYPE_ACTIVE_DIE:int = 9;
      
      public static const TYPE_ACTIVE_DEADSKILL:int = 10;
      
      public static const TYPE_ACTIVE_RELIVE:int = 11;
      
      public static const TYPE_ACTIVE_HURTHP:int = 12;
      
      public static const TYPE_NONE:int = 0;
      
      public static const TYPE_HERO:int = 1;
      
      public static const TYPE_ENEMY:int = 2;
      
      public static const TYPE_NPC:int = 3;
      
      public static const TYPE_SOULFORMATION:int = 4;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var FIdlePosition:Vector.<int>;
      
      protected var FDemoPeople:Sprite;
      
      protected var FId:uint;
      
      protected var FResourcesId:uint;
      
      protected var FBigHeadId:uint;
      
      protected var FTexture:TTexture;
      
      protected var FBitmap:Bitmap;
      
      protected var FTickReference:int;
      
      protected var FIndex:int;
      
      protected var FHpBar:MovieClip;
      
      protected var FWuxingBmp:Bitmap;
      
      protected var FWuxingBmp1:Bitmap;
      
      protected var FWuxingBmpVec:Vector.<Bitmap>;
      
      protected var FShaderBmp:Bitmap;
      
      protected var FBgSprite:Sprite;
      
      protected var FEffectSprite:Sprite;
      
      protected var FEffectBitmap:Bitmap;
      
      protected var FIsInFight:Boolean;
      
      protected var FHasTip:Boolean;
      
      protected var FTargets:Vector.<TRole>;
      
      protected var FResults:Vector.<TTargetInfo>;
      
      protected var FSkillId:int;
      
      protected var FSkilling:Boolean;
      
      protected var FCallBackDict:Dictionary;
      
      protected var FTimeDict:Dictionary;
      
      protected var FResourcesType:int;
      
      protected var FNpc:TNPC;
      
      protected var FEnemy:TEnemy;
      
      protected var FHero:TBaseHero;
      
      protected var FSoulArray:TSoulArray;
      
      protected var FAttackEffect:Object;
      
      protected var FIsLeft:Boolean;
      
      protected var FIsDie:Boolean;
      
      protected var FShowName:Boolean;
      
      protected var FNameTextFiled:TextField;
      
      protected var FNameSprite:Sprite;
      
      protected var FNameTextFormat:TextFormat;
      
      protected var FBuffSprite:Sprite;
      
      protected var FIsAntiColorBlackWhite:Boolean;
      
      protected var FIsRedAntiColor:Boolean;
      
      protected var FIsShowHighLight:Boolean;
      
      protected var FRoleModelBins:TBins;
      
      protected var FBaseHeroBins:TBins;
      
      protected var FEnemyBins:TBins;
      
      protected var FNPCBins:TBins;
      
      protected var FCoordinate:TCoordinate;
      
      protected var FCursorHovering:Boolean;
      
      protected var FInitHpBarHeight:Boolean;
      
      protected var FModelId:uint;
      
      protected var FRoleBattleInfo:TRoleBattleInfo;
      
      public var SoulFormationID:int;
      
      public function TActive(param1:TUIComponent, param2:int, param3:uint = 0, param4:Boolean = false, param5:Boolean = true, param6:Boolean = false, param7:int = 0)
      {
         super(param1);
         this.FId = param2;
         this.FModelId = param3;
         this.FIsInFight = param4;
         this.SoulFormationID = param7;
         this.FResourcesType = this.CheckType();
         this.FIsDie = false;
         this.FShowName = param5;
         this.FHasTip = param6;
         this.FAttackEffect = {};
         this.FInitHpBarHeight = false;
         this.FSkilling = false;
         this.FCoordinate = new TCoordinate();
         this.InitActive();
      }
      
      protected function CheckType() : uint
      {
         if(this.SoulFormationID != 0)
         {
            return TYPE_SOULFORMATION;
         }
         return this.FId > 22100000 ? uint(TYPE_NPC) : (this.FId < 18000000 ? (this.FId > 12101000 ? uint(TYPE_ENEMY) : uint(TYPE_HERO)) : uint(TYPE_NONE));
      }
      
      protected function InitActive() : void
      {
         var _loc1_:TResourceRepositoryTexture = null;
         this.FRoleModelBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
         this.FBaseHeroBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BaseHero);
         this.FEnemyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Enemy);
         this.FNPCBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NPC);
         this.FCallBackDict = new Dictionary(true);
         this.FTimeDict = new Dictionary(true);
         this.FIsShowHighLight = false;
         if(this.FIsInFight)
         {
            this.FIndex = TYPE_ACTIVE_FIGHT_IDLE;
         }
         else
         {
            this.FIndex = TYPE_ACTIVE_IDLE;
         }
         this.GetAttackEffect();
         this.FBgSprite = new Sprite();
         addChild(this.FBgSprite);
         this.FBgSprite.mouseEnabled = false;
         this.FBgSprite.mouseChildren = false;
         this.FShaderBmp = TPoolBitmap.GetBitmap();
         addChild(this.FShaderBmp);
         this.FBitmap = new Bitmap();
         addChild(this.FBitmap);
         this.FNameSprite = new Sprite();
         addChild(this.FNameSprite);
         this.FNameSprite.mouseEnabled = false;
         this.FNameSprite.mouseChildren = false;
         this.FEffectSprite = new Sprite();
         addChild(this.FEffectSprite);
         this.FEffectSprite.mouseEnabled = false;
         this.FEffectSprite.mouseChildren = false;
         this.FEffectBitmap = TPoolBitmap.GetBitmap();
         addChild(this.FEffectBitmap);
         this.FResourcesId = this.GetResourceID(this.FId);
         this.FBigHeadId = this.GetBigHeadID(this.FId);
         _loc1_ = SResourcesCore.TexturesModel;
         this.FTexture = _loc1_.GetTextureByIdentifier(this.FResourcesId);
         if(this.FTexture == null)
         {
            this.FDemoPeople = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
            addChild(this.FDemoPeople);
            this.FBitmap.visible = false;
            SResourcesCore.TexturesModel.LoadSecondary(this.FResourcesId,this.FModelId);
         }
         this.CheckName();
         this.FBuffSprite = new Sprite();
         addChild(this.FBuffSprite);
      }
      
      protected function CheckName() : void
      {
         var _loc1_:THero = null;
         var _loc2_:uint = 0;
         if(this.FShowName)
         {
            if(this.FNameTextFiled == null)
            {
               this.FNameTextFiled = new TextField();
               this.FNameSprite.addChild(this.FNameTextFiled);
               this.FNameTextFormat = new TextFormat();
               this.FNameTextFormat.size = 12;
               this.FNameTextFormat.align = TextFormatAlign.CENTER;
               this.FNameTextFiled.defaultTextFormat = this.FNameTextFormat;
               this.FNameTextFiled.width = 120;
               this.FNameTextFiled.height = 30;
               this.FNameTextFiled.x = -this.FNameTextFiled.width / 2;
               this.FNameTextFiled.mouseEnabled = false;
            }
            if(this.FHero != null)
            {
               if(this.FHero.IsMain)
               {
                  _loc1_ = SLogicsCore.Character.GetMainHero();
                  this.FNameTextFiled.text = _loc1_.Name;
                  _loc2_ = _loc1_.Quality;
               }
               else
               {
                  this.FNameTextFiled.text = this.FHero.Name;
                  _loc2_ = uint(this.FHero.Quality);
               }
            }
            else if(this.FEnemy != null)
            {
               this.FNameTextFiled.text = this.FEnemy.Name;
               _loc2_ = uint(this.FEnemy.Quality);
            }
            else if(this.FNpc != null)
            {
               this.FNameTextFiled.text = this.FNpc.Name;
               _loc2_ = 1;
            }
            else
            {
               this.FNameTextFiled.text = STRING_BATTLE.STRING_PassDoor;
               _loc2_ = 1;
            }
            this.FNameTextFiled.textColor = QUALITYCOLOR_INDEX[_loc2_];
            this.FNameTextFiled.visible = true;
         }
         else if(this.FNameTextFiled != null)
         {
            this.FNameTextFiled.visible = false;
         }
      }
      
      protected function IsMouseInBitmapRect() : Boolean
      {
         if(this.FBitmap.bitmapData == null)
         {
            return true;
         }
         if(mouseX < this.FBitmap.x + this.FBitmap.width && mouseX > this.FBitmap.x && mouseY < this.FBitmap.y + this.FBitmap.height && mouseY > this.FBitmap.y)
         {
            return true;
         }
         return false;
      }
      
      protected function GetResourceID(param1:int) : int
      {
         var _loc2_:TRoleModel = null;
         _loc2_ = this.FRoleModelBins.GetDatebaseByIdentifier(param1) as TRoleModel;
         if(_loc2_ == null)
         {
            return param1;
         }
         return _loc2_.Model;
      }
      
      protected function GetBigHeadID(param1:int) : int
      {
         var _loc2_:TRoleModel = null;
         _loc2_ = this.FRoleModelBins.GetDatebaseByIdentifier(param1) as TRoleModel;
         if(_loc2_ == null)
         {
            return param1;
         }
         return _loc2_.RoleStyle;
      }
      
      protected function PlayRun() : void
      {
         if(this.FIndex == TYPE_ACTIVE_RUN)
         {
            return;
         }
         this.FIndex = TYPE_ACTIVE_RUN;
      }
      
      protected function PlayIdle() : void
      {
         if(this.FIndex == TYPE_ACTIVE_IDLE)
         {
            return;
         }
         this.FIndex = TYPE_ACTIVE_IDLE;
      }
      
      protected function PlayFightIdle() : void
      {
         if(this.FIndex == TYPE_ACTIVE_FIGHT_IDLE)
         {
            return;
         }
         this.FIndex = TYPE_ACTIVE_FIGHT_IDLE;
      }
      
      protected function PlayAttack() : void
      {
         this.FTickReference = 0;
         this.FIndex = TYPE_ACTIVE_ATTACK;
      }
      
      protected function PlayAttacked() : void
      {
         this.FTickReference = 0;
         this.FIndex = TYPE_ACTIVE_ATTACKED;
      }
      
      protected function PlaySkill() : void
      {
         this.FTickReference = 0;
         this.FIndex = TYPE_ACTIVE_SKILL;
      }
      
      protected function GetAttackEffect() : void
      {
         var _loc1_:TBaseHero = null;
         var _loc2_:String = null;
         this.FHero = null;
         this.FEnemy = null;
         this.FNpc = null;
         this.FSoulArray = null;
         if(this.FResourcesType == TYPE_HERO)
         {
            this.FHero = this.FBaseHeroBins.GetDatebaseByIdentifier(this.FId) as TBaseHero;
            if(this.FHero)
            {
               this.FAttackEffect = Json.decode(this.FHero.AttackEffect);
            }
         }
         else if(this.FResourcesType == TYPE_ENEMY)
         {
            this.FEnemy = this.FEnemyBins.GetDatebaseByIdentifier(this.FId) as TEnemy;
            if(this.FEnemy)
            {
               this.FAttackEffect = Json.decode(this.FEnemy.Effects);
            }
         }
         else if(this.FResourcesType == TYPE_NPC)
         {
            this.FNpc = this.FNPCBins.GetDatebaseByIdentifier(this.FId) as TNPC;
            this.FAttackEffect = {};
         }
         else if(this.FResourcesType == TYPE_SOULFORMATION)
         {
            this.FSoulArray = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,this.SoulFormationID) as TSoulArray;
            if(this.FRoleBattleInfo)
            {
               _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FRoleBattleInfo.RoleId) as TBaseHero;
            }
            if(Boolean(this.FSoulArray) && Boolean(_loc1_))
            {
               _loc2_ = _loc1_.Profession == 3 ? this.FSoulArray.attackEffect1 : this.FSoulArray.attackEffect;
               this.FAttackEffect = Json.decode(_loc2_);
            }
         }
         else
         {
            this.FAttackEffect = {};
         }
         if(this.FAttackEffect == 0)
         {
            this.FAttackEffect = {};
         }
      }
      
      public function get SoundID() : uint
      {
         if(this.FResourcesType == TYPE_HERO)
         {
            return this.FHero.Soundid;
         }
         if(this.FResourcesType == TYPE_ENEMY)
         {
            return this.FEnemy.Soundid;
         }
         return 0;
      }
      
      public function get SkillSound() : uint
      {
         if(this.FResourcesType == TYPE_HERO)
         {
            return this.FHero.Skillsound;
         }
         if(this.FResourcesType == TYPE_ENEMY)
         {
            return this.FEnemy.Skillsound;
         }
         return 0;
      }
      
      public function get ResourcesId() : uint
      {
         return this.FResourcesId;
      }
      
      public function IsBaseHero() : Boolean
      {
         return this.FResourcesType == TYPE_HERO;
      }
      
      override public function get Cursor() : uint
      {
         var _loc1_:Boolean = false;
         if(this.FCursorHovering)
         {
            return CONST_CURSOR.CURSORID_Enemy;
         }
         return CONST_CURSOR.CURSORID_Default;
      }
      
      override public function get CursorDisplayObject() : TUIComponent
      {
         return this.Parent.Parent.Parent;
      }
      
      public function get RoleWidth() : Number
      {
         if(this.FBitmap.bitmapData != null)
         {
            return this.FBitmap.width;
         }
         if(this.FDemoPeople.visible == true)
         {
            return this.FDemoPeople.width;
         }
         return 0;
      }
      
      public function get RoleHeight() : Number
      {
         if(this.FBitmap.bitmapData != null)
         {
            return this.FBitmap.height;
         }
         if(Boolean(this.FDemoPeople) && this.FDemoPeople.visible == true)
         {
            return this.FDemoPeople.height;
         }
         return 0;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         if(this.FNameSprite != null)
         {
            this.FNameSprite.scaleX = scaleX;
         }
      }
      
      public function get direction() : Boolean
      {
         return this.FIsLeft;
      }
      
      public function set direction(param1:Boolean) : void
      {
         this.FIsLeft = param1;
         this.scaleX = Math.abs(scaleX) * (param1 ? 1 : -1);
      }
      
      public function set PosX(param1:int) : void
      {
         if(x < param1)
         {
            this.scaleX = Math.abs(scaleX);
         }
         else if(x > param1)
         {
            this.scaleX = -Math.abs(scaleX);
         }
         x = param1;
      }
      
      public function get PosX() : int
      {
         return x;
      }
      
      public function set PosY(param1:int) : void
      {
         y = param1;
      }
      
      public function get PosY() : int
      {
         return y;
      }
      
      public function IsSkill(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         _loc2_ = false;
         if(param1 < 0)
         {
            return false;
         }
         if(this.FEnemy != null)
         {
            _loc2_ = Boolean(this.FEnemy.Normal != param1);
         }
         else if(this.FHero != null)
         {
            _loc2_ = Boolean(this.FHero.NormalAttack != param1);
         }
         return _loc2_;
      }
      
      public function ActiveType(param1:int) : int
      {
         if(this.SoulFormationID > 0)
         {
            return TYPE_ACTIVE_SKILL;
         }
         if(this.IsSkill(param1))
         {
            return TYPE_ACTIVE_SKILL;
         }
         if(param1 > 0)
         {
            return TYPE_ACTIVE_ATTACK;
         }
         if(param1 == -1)
         {
            return TYPE_ACTIVE_GRIDFILE;
         }
         if(param1 == -2)
         {
            return TYPE_ACTIVE_DEADSKILL;
         }
         if(param1 == -3)
         {
            return TYPE_ACTIVE_RELIVE;
         }
         if(param1 == -4)
         {
            return TYPE_ACTIVE_HURTHP;
         }
         return TYPE_ACTIVE_IDLE;
      }
      
      public function get EffectSprite() : Sprite
      {
         return this.FEffectSprite;
      }
      
      public function get HasTip() : Boolean
      {
         return this.FHasTip;
      }
      
      public function set ShowHighLight(param1:Boolean) : void
      {
         if(this.FIsAntiColorBlackWhite || this.FIsRedAntiColor)
         {
            return;
         }
         if(this.FIsDie)
         {
            return;
         }
         if(this.FIsShowHighLight == param1)
         {
            return;
         }
         this.FIsShowHighLight = param1;
         this.FBitmap.filters = this.FIsShowHighLight ? [TGameUtil.highLightFilters] : [];
      }
      
      public function get NpcData() : TNPC
      {
         return this.FNpc;
      }
      
      public function get EnemyData() : TEnemy
      {
         return this.FEnemy;
      }
      
      public function get HeroData() : TBaseHero
      {
         return this.FHero;
      }
      
      public function get Id() : int
      {
         return this.FId;
      }
      
      public function get Display() : DisplayObject
      {
         if(this.FBitmap.bitmapData != null)
         {
            return this.FBitmap;
         }
         if(Boolean(this.FDemoPeople) && this.FDemoPeople.visible == true)
         {
            return this.FDemoPeople;
         }
         return this.FDemoPeople;
      }
      
      public function get SkillId() : int
      {
         return this.FSkillId;
      }
      
      public function get Skilling() : Boolean
      {
         return this.FSkilling;
      }
      
      public function get CursorHovering() : Boolean
      {
         return this.FCursorHovering;
      }
      
      public function set CursorHovering(param1:Boolean) : void
      {
         this.FCursorHovering = param1;
      }
      
      public function get IdlePositionX() : int
      {
         return this.FIdlePosition[0];
      }
      
      public function get IdlePositionY() : int
      {
         return this.FIdlePosition[1];
      }
      
      public function get BgSprite() : Sprite
      {
         return this.FBgSprite;
      }
      
      public function get ModelId() : uint
      {
         return this.FModelId;
      }
      
      public function set ModelId(param1:uint) : void
      {
         this.FModelId = param1;
      }
      
      public function set RoleBattleInfo(param1:TRoleBattleInfo) : void
      {
         this.FRoleBattleInfo = param1;
      }
      
      public function CheckDirection() : void
      {
      }
      
      public function MoveTo(param1:Function, param2:int, param3:int, param4:Number = 500) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         TweenUtil.removeTween(this,false);
         if(param2 == int(this.x) && param3 == int(this.y))
         {
            param1();
            return;
         }
         _loc5_ = TGameUtil.GetDistance(param2,param3,this.x,this.y);
         _loc6_ = 1000 * _loc5_ / param4;
         TweenUtil.to(this,_loc6_,{
            "PosX":param2,
            "PosY":param3,
            "onComplete":param1
         });
      }
      
      public function ActivePlay(param1:int, param2:int = 0, param3:Vector.<TRole> = null, param4:Vector.<TTargetInfo> = null, param5:Function = null, param6:uint = 0, param7:Boolean = false) : void
      {
         if(this.FIsDie)
         {
            return;
         }
         this.FTargets = param3;
         this.FSkillId = param2;
         this.FSkilling = this.IsSkill(this.FSkillId);
         if(param1 == TYPE_ACTIVE_RUN)
         {
            this.PlayRun();
         }
         else if(param1 == TYPE_ACTIVE_IDLE)
         {
            this.PlayIdle();
            this.CheckDirection();
            if(param5 != null)
            {
               param5();
            }
         }
         else if(param1 == TYPE_ACTIVE_FIGHT_IDLE)
         {
            this.PlayFightIdle();
            this.CheckDirection();
            if(param5 != null)
            {
               param5();
            }
         }
      }
      
      public function UpdateActive() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:TAnimationFrame = null;
         var _loc4_:TAnimationSequence = null;
         var _loc5_:BitmapData = null;
         var _loc6_:Function = null;
         var _loc7_:TSkillEffectConfig = null;
         var _loc8_:Class = null;
         if(stage == null)
         {
            return;
         }
         if(this.FHero != null && this.FHero.TransState >= 1 && !this.FHero.IsMain)
         {
            TGameUtil.ShowEffectById(this.FEffectBitmap,CONST_COMMON.Nija_Reincarnation_Effect_NotMain);
            this.FEffectBitmap.visible = true;
         }
         else
         {
            if(this.FEffectBitmap.bitmapData)
            {
               this.FEffectBitmap.bitmapData.dispose();
               this.FEffectBitmap.bitmapData = null;
            }
            this.FEffectBitmap.visible = false;
         }
         if(this.FShaderBmp.bitmapData == null)
         {
            TGameUtil.ShowEffectById(this.FShaderBmp,CONST_BATTLE.Public_Effect_Shadow);
         }
         if(this.FTexture != null)
         {
            if(this.FTexture.Count == 0)
            {
               this.FTexture = null;
            }
         }
         if(this.FTexture == null)
         {
            this.FTexture = SResourcesCore.TexturesModel.GetTextureByIdentifier(this.FResourcesId);
            if(this.FTexture == null)
            {
               SResourcesCore.TexturesModel.LoadSecondary(this.FResourcesId,this.FModelId);
               if(this.FDemoPeople)
               {
                  this.FDemoPeople.visible = true;
               }
               else
               {
                  this.FDemoPeople = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
                  addChild(this.FDemoPeople);
               }
            }
         }
         if(this.FTexture != null)
         {
            _loc4_ = this.FTexture.GetAnimationSequenceByIndex(this.FIndex);
            if(_loc4_ != null)
            {
               _loc3_ = _loc4_.GetAnimationFrameByTick(this.FTickReference);
               if(_loc3_ != null)
               {
                  _loc5_ = _loc3_.Surface;
                  if(this.FBitmap.bitmapData != _loc5_)
                  {
                     this.FBitmap.bitmapData = _loc5_;
                     this.FBitmap.x = -_loc3_.Pivot.X;
                     this.FBitmap.y = -_loc3_.Pivot.Y;
                  }
               }
               if(_loc3_ == null)
               {
                  _loc6_ = this.FCallBackDict[this.FIndex];
                  if(_loc4_.Timing != 2)
                  {
                     if(this.FIsInFight)
                     {
                        this.FIndex = TYPE_ACTIVE_FIGHT_IDLE;
                     }
                     else
                     {
                        this.FIndex = TYPE_ACTIVE_IDLE;
                     }
                     if(this.FIdlePosition != null)
                     {
                        this.x = this.FIdlePosition[0];
                        this.y = this.FIdlePosition[1];
                     }
                  }
                  if(_loc6_ != null)
                  {
                     _loc6_();
                  }
               }
               this.FTickReference += 1000 / stage.frameRate;
            }
            if(this.FDemoPeople != null)
            {
               this.FBitmap.visible = true;
               this.FDemoPeople.visible = false;
               this.CheckDirection();
            }
         }
         if(this.FShowName)
         {
            this.FNameSprite.y = -this.RoleHeight - 12;
         }
      }
      
      public function CheckMouseInColor() : Boolean
      {
         if(this.FIsDie)
         {
            return false;
         }
         if(this.IsMouseInBitmapRect())
         {
            if(this.FBitmap.bitmapData == null)
            {
               if(this.FDemoPeople != null && TGameUtil.CheckInArea(this.FDemoPeople,mouseX - this.FDemoPeople.x,mouseY - this.FDemoPeople.y))
               {
                  return true;
               }
               return false;
            }
            if(TGameUtil.CheckIsApha(this.FBitmap,mouseX - this.FBitmap.x,mouseY - this.FBitmap.y))
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function ReloadRole() : void
      {
         var _loc1_:TResourceRepositoryTexture = null;
         _loc1_ = SResourcesCore.TexturesModel;
         this.FTexture = _loc1_.GetTextureByIdentifier(this.FResourcesId);
         if(this.FTexture == null)
         {
            if(this.FDemoPeople == null)
            {
               this.FDemoPeople = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
               addChild(this.FDemoPeople);
            }
            this.FDemoPeople.visible = true;
            this.FBitmap.visible = false;
            SResourcesCore.TexturesModel.LoadSecondary(this.FResourcesId,this.FModelId);
         }
      }
      
      public function ResetActive(param1:TUIComponent, param2:uint, param3:uint = 0, param4:Boolean = false, param5:Boolean = true, param6:Boolean = false) : void
      {
         var _loc7_:TResourceRepositoryTexture = null;
         FParent = param1;
         if(param1 != null)
         {
            param1.addChild(this);
         }
         Visible = true;
         this.FId = param2;
         this.FModelId = param3;
         this.FResourcesType = this.CheckType();
         this.FInitHpBarHeight = false;
         this.direction = true;
         this.FBitmap.bitmapData = null;
         this.GetAttackEffect();
         this.FIsInFight = param4;
         this.FShowName = param5;
         this.FHasTip = param6;
         this.FIsDie = false;
         this.FCallBackDict = new Dictionary(true);
         if(this.FIsInFight)
         {
            this.FIndex = TYPE_ACTIVE_FIGHT_IDLE;
         }
         else
         {
            this.FIndex = TYPE_ACTIVE_IDLE;
         }
         this.FTargets = null;
         this.FResourcesId = this.GetResourceID(this.FId);
         this.FBigHeadId = this.GetBigHeadID(this.FId);
         _loc7_ = SResourcesCore.TexturesModel;
         this.FTexture = _loc7_.GetTextureByIdentifier(this.FResourcesId);
         if(this.FTexture == null)
         {
            if(this.FDemoPeople == null)
            {
               this.FDemoPeople = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
               addChild(this.FDemoPeople);
            }
            this.FDemoPeople.visible = true;
            this.FBitmap.visible = false;
            SResourcesCore.TexturesModel.LoadSecondary(this.FResourcesId,this.FModelId);
         }
         this.CheckName();
         this.ResetColor();
         x = 0;
         y = 0;
      }
      
      public function set AntiColorBlackWhite(param1:Boolean) : void
      {
         if(this.FIsDie)
         {
            return;
         }
         this.FIsAntiColorBlackWhite = param1;
         if(param1)
         {
            this.FBitmap.filters = [TGameUtil.AntiColorFilters,TGameUtil.rBlackFilters];
            this.FShaderBmp.filters = [TGameUtil.AntiColorFilters,TGameUtil.rBlackFilters];
            this.FBuffSprite.filters = [TGameUtil.AntiColorFilters,TGameUtil.rBlackFilters];
            if(this.FHpBar)
            {
               this.FHpBar.filters = [TGameUtil.AntiColorFilters,TGameUtil.rBlackFilters];
            }
            this.FBgSprite.filters = [TGameUtil.AntiColorFilters,TGameUtil.rBlackFilters];
         }
         else
         {
            this.FBitmap.filters = [];
            this.FShaderBmp.filters = [];
            this.FBuffSprite.filters = [];
            if(this.FHpBar)
            {
               this.FHpBar.filters = [];
            }
            this.FBgSprite.filters = [];
         }
      }
      
      public function set RedAntiColor(param1:Boolean) : void
      {
         if(this.FIsDie)
         {
            return;
         }
         this.FIsRedAntiColor = param1;
         if(param1)
         {
            this.FBitmap.filters = [TGameUtil.rBlackFilters,TGameUtil.RedAntiColorFilters];
            this.FShaderBmp.filters = [TGameUtil.rBlackFilters,TGameUtil.RedAntiColorFilters];
            this.FBuffSprite.filters = [TGameUtil.rBlackFilters,TGameUtil.RedAntiColorFilters];
            if(this.FHpBar)
            {
               this.FHpBar.filters = [TGameUtil.rBlackFilters,TGameUtil.RedAntiColorFilters];
            }
            this.FBgSprite.filters = [TGameUtil.rBlackFilters,TGameUtil.RedAntiColorFilters];
         }
         else
         {
            this.FBitmap.filters = [];
            this.FShaderBmp.filters = [];
            this.FBuffSprite.filters = [];
            if(this.FHpBar)
            {
               this.FHpBar.filters = [];
            }
            this.FBgSprite.filters = [];
         }
      }
      
      public function ResetColor() : void
      {
         this.FBitmap.filters = [];
         this.FShaderBmp.filters = [];
         this.FBuffSprite.filters = [];
         if(this.FHpBar)
         {
            this.FHpBar.filters = [];
         }
         this.FBgSprite.filters = [];
      }
      
      public function SetRoleName(param1:String) : void
      {
         if(this.FNameTextFiled != null)
         {
            this.FNameTextFiled.text = param1;
         }
      }
      
      public function Releasing() : void
      {
         this.FTexture = null;
         this.FBitmap.bitmapData = null;
         this.FShaderBmp.bitmapData = null;
         this.FEffectBitmap.bitmapData = null;
      }
   }
}

